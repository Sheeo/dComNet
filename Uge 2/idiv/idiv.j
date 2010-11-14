.method idiv	// int idiv(int x, int y)
.args 3
.locals 1
.define x = 1
.define y = 2
.define q = 3	// int q;

	bipush 0
	istore q	// q = 0;
WHILE:
	iload x
	iload y
	isub
	dup
	ifeq END_WHILE
	iflt END_WHILE	// while (x >= y) {
	iload y
	iload x
	isub
	istore x	// x = x-y
	bipush 1
	iload q
	iadd
	istore q	// q = q+1
	goto WHILE	// }

END_WHILE:
WHILE2:
	iload x
	bipush 0
	iload y
	isub
	isub
	dup
	ifeq END_WHILE2
	iflt END_WHILE2	// while ( x <= -y )

	iload x
	iload y
	iadd
	istore x	// x = x + y
	iload q
	bipush 1
	isub
	istore q	// q = q - 1
	goto WHILE2	// }

END_WHILE2:
	iload q
	ireturn		// return q

.method main
.args 3
	bipush 120 // objref
	iload 1
	iload 2
	invokevirtual idiv
	ireturn

// vim:syn=bytecode:
