.section .data
n: .long 10
intfmt: .string "%d\n\0"
usagefmt: .string "Usage: %s <n>\n"


.section .text
.globl _start

_start:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp       # place for local variables

	xor %eax, %eax
	cmpl %eax, 12(%ebp) # argc <=> 1
	je usage

	pushl $0            # strtol(argv[1], &lv0, 0)
	movl %ebp, %eax
	subl $4, %eax
	pushl %eax          # &lv0
	pushl 12(%ebp)      # argv[0]
	call strtol         # strtol()
	addl $12, %esp
	movl %eax, -8(%ebp) # store ret val in lv1

	xor %ebx, %ebx      # ebx = 0
	movl -4(%ebp), %eax # read the (char *)
	movzbl (%eax), %eax # read the (char)
	cmpl %ebx, %eax     # *lv0 <=> 0
	jne usage

	pushl -8(%ebp)      # push param
	call fib            # fib()
	addl $4, %esp       # pop param

	pushl $0
	pushl %eax
	pushl $intfmt
	call printf         # printf("%d\n", fib(n));
	addl $12, %esp

	movl $0, %ebx       # return value 0
	movl $1, %eax       # opcode for exiting
	int $0x80           # syscall


usage:
	pushl $0
	pushl 8(%ebp)
	pushl $usagefmt
	call printf

	movl $1, %ebx       # return value
	movl $1, %eax       # opcode for exiting
	int $0x80           # syscall


fib:                  # fib(int n)
	pushl %ebp          # add prev stack base to stack
	movl %esp, %ebp     # set stack base to cur stack pt

	movl $2, %ebx       # read 2 into ebx
	cmpl 8(%ebp), %ebx  # n <=> 2
	jg ret              # return n if n < 2

	movl 8(%ebp), %eax
	decl %eax
	pushl %eax          # push n-1
	call fib            # fib(n-1)
	addl $4, %esp       # pop param

	pushl %eax          # push ret val

	movl 8(%ebp), %eax
	subl $2, %eax
	pushl %eax          # push n-2
	call fib            # fib(n-2)
	addl $4, %esp       # pop param

	addl (%esp), %eax   # add fib(n-1) to ret val
	addl $4, %esp       # pop ret val of fib(n-1)

ret:
	movl %ebp, %esp  # restore esp
	popl %ebp        # restore ebp
	ret
