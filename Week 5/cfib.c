int fib(int n) {
	if (n < 2) return n;
	return fib(n-2)+fib(n-1);
}
void _start() {
	int val = fib(5);
	asm("movl %0, %%ebx\n\t"
			"movl $1, %%eax\n\t"
			"int $0x80"
			: // output (none)
			: "r" ( val ) // input
			: "%eax", "%ebx" // clobbered
			);
}
