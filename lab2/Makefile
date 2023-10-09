.PHONY:fib,factorial
fib:
	arm-linux-gnueabihf-gcc fib.S -o fib.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./fib.out
	rm -fr fib.out
factorial:
	arm-linux-gnueabihf-gcc factorial.S -o factorial.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./factorial.out
	rm factorial.out