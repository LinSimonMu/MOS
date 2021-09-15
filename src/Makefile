CFILES = $(wildcard *.c)
OFILES = $(CFILES:.c=.o)
GCCFLAGS = -g -Wall -O0 -ffreestanding -nostdinc -nostdlib -nostartfiles
GCCPATH = ../Tools/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf/bin

all: clean kernel

boot.o: boot.S
	$(GCCPATH)/aarch64-none-elf-gcc $(GCCFLAGS) -c boot.S -o boot.o

%.o: %.c
	$(GCCPATH)/aarch64-none-elf-gcc $(GCCFLAGS) -c $< -o $@

kernel: boot.o $(OFILES)
	$(GCCPATH)/aarch64-none-elf-ld -nostdlib boot.o $(OFILES) -T link.ld -o kernel.elf
	#$(GCCPATH)/aarch64-none-elf-objcopy -O binary kernel.elf kernel
	cp kernel.elf ../kernel

clean:
	/bin/rm kernel.elf *.o *.img > /dev/null 2> /dev/null || true