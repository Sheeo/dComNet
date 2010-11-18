.method geq
.args 3
	iload 1
	iflt ANEG
APOS:
	iload 2
	iflt APOSBNEG
	goto SAMESIGN // a positive, b positive
ANEG:
	iload 2
	iflt SAMESIGN // a negative, b negative
	goto ANEGBPOS
APOSBNEG:
	bipush 1
	ireturn
ANEGBPOS:
	bipush 0
	ireturn
SAMESIGN:
	iload 1
	iload 2
	isub
	iflt ELSE
THEN:
	bipush 1
	ireturn
ELSE:
	bipush 0
	ireturn

.method main
.args 3
	bipush 122
	iload 1
	iload 2
	invokevirtual geq
	ireturn
