#include <stdio.h>
int fib(int n) {
	if (n < 2) return n;
	return fib(n-2)+fib(n-1);
}
void _start(char *argv0, char *argv1) {
	int n, val;
	char *s;
	n = strtol(argv1, &s, 0);
	val = fib(n);
	printf("%d\n", val);
	asm("movl $0, %ebx\n\t" // return value
	    "movl $1, %eax\n\t" // opcode for exit
	    "int $0x80");
}
