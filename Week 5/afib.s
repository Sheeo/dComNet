.section .data
n: .long 10


.section .text
.globl _start

_start:
	pushl n          # push param
	call fib         # fib()
	addl $4, %esp    # pop param

	movl %eax, %ebx  # use ret val as exit code
	movl $1, %eax    # opcode for exiting
	int $0x80


fib:               # fib(int n)
	pushl %ebp       # add prev stack base to stack
	movl %esp, %ebp  # set stack base to cur stack pt

	movl $2, %ebx    # read 2 into ebx
	cmpl 8(%ebp), %ebx  # n <=> 2
	jg ret           # return n if n < 2

	movl 8(%ebp), %eax
	decl %eax
	pushl %eax       # push n-1
	call fib         # fib(n-1)
	addl $4, %esp    # pop param

	pushl %eax       # push ret val

	movl 8(%ebp), %eax
	subl $2, %eax
	pushl %eax       # push n-2
	call fib         # fib(n-2)
	addl $4, %esp    # pop param

	addl (%esp), %eax # add fib(n-1) to ret val
	addl $4, %esp    # pop ret val of fib(n-1)

ret:
	movl %ebp, %esp  # restore esp
	popl %ebp        # restore ebp
	ret
