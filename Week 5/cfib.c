extern void exit(int);
void _start() {
	int test = 2;
	asm("movl %0, %%ebx\n\t"
			"movl $1, %%eax\n\t"
			"int $0x80"
			: // output (none)
			: "r" ( test ) // input
			: "%eax", "%ebx" // clobbered
			);
}
