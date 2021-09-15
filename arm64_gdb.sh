qemu-system-aarch64 \
        -machine virt,virtualization=true,gic-version=3 \
        -nographic \
        -m size=1024M \
        -cpu cortex-a72 \
        -smp 4 \
        -kernel kernel \
	-S -s
