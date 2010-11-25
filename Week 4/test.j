.method main
.args 1
	bipush 4
	bipush 5
	ishl
	pop
	bipush 120
	bipush 3
	iushr
	pop
	bipush -4
	bipush 1
	ishr
	pop
	bipush 5
	bipush 2
	ishr
	ireturn
