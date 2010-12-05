#include <stdio.h>
int fib(int n) {
	if (n < 2) return n;
	return fib(n-2)+fib(n-1);
}
#define ret(v) asm("movl " v ", %ebx\n\t" /* return value */ \
	                 "movl $1, %eax\n\t" /* opcode for exit */ \
	                 "int $0x80");
void _start(char *argv0, char *argv1) {
	int n, val;
	char *s;
	if (argv1 == NULL) {
		if (1 != scanf("%d", &n)) {
			printf("Usage: %s <n>\n", argv0);
			ret("$1");
			return;
		}
	} else {
		n = strtol(argv1, &s, 0);
		if (*s) {
			printf("Usage: %s <n>\n", argv0);
			ret("$1");
			return;
		}
	}
	val = fib(n);
	printf("%d\n", val);
	ret("$0");
}
