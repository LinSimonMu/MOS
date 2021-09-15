.section ".text.boot"  // 用于确保链接器将代码段放置于内核镜像的开头
.global _start  // 代码从这里开始执行

_start:
    // 检查处理器ID，如果是0则为主核心，继续执行，否则挂起
    mrs     x1, mpidr_el1
    and     x1, x1, #3
    cbz     x1, 2f
    // 代码没有运行在主核心上，所以用死循环挂起代码
1:  wfe
    b       1b
2:  // 代码运行在主核心上，继续

    // 设置堆栈区的起点
    ldr     x1, =_start
    mov     sp, x1

    // 将BSS段清零
    ldr     x1, =__bss_start     // 起始地址
    ldr     w2, =__bss_size      // 段大小
3:  cbz     w2, 4f               // 如果为0，退出循环
    str     xzr, [x1], #8
    sub     w2, w2, #1
    cbnz    w2, 3b               // 如果不为0，继续循环

    // 跳转到main()，请确保main()不会return
4:  bl      main
    // 万一main函数return了，同样用死循环挂起主核心
    b       1b