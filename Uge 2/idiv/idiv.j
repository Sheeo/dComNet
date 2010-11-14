.method idiv	// int idiv(int x, int y)
.args 3
.locals 1
.define x = 1
.define y = 2
.define q = 3	// int q;

	bipush 0
	istore q	// q = 0;
	iload x
	iflt NEGX
	iload y
	iflt POSXNEGY
	goto POSXPOSY
NEGX:
	iload y
	iflt NEGXNEGY
	goto NEGXPOSY

POSXPOSY:
	iload x
	iload y
	isub
	iflt END_WHILE	// while (x >= y) {
	iload x
	iload y
	isub
	istore x	// x = x-y
	bipush 1
	iload q
	iadd
	istore q	// q = q+1
	goto POSXPOSY	// }

POSXNEGY:
	iload x
	iload y
	iadd
	iflt END_WHILE	// while (x >= -y) {
	iload x
	iload y
	iadd
	istore x	// x = x+y
	iload q
	bipush 1
	isub
	istore q	// q = q-1
	goto POSXNEGY	// }


NEGXPOSY:
	iload x
	iload y
	iadd
	dup
	ifeq NEGXPOSY_WHILE
	iflt NEGXPOSY_WHILE
	goto END_WHILE	// while (x <= -y) {

NEGXPOSY_WHILE:
	iload x
	iload y
	iadd
	istore x	// x = x+y

	iload q
	bipush 1
	isub
	istore q	// q = q-1
	goto NEGXPOSY	// }


NEGXNEGY:
	iload x
	iload y
	isub
	dup
	iflt NEGXNEGY_WHILE
	ifeq NEGXNEGY_WHILE
	goto END_WHILE	// while (x <= y) {
NEGXNEGY_WHILE:
	iload x
	iload y
	isub
	istore x	// x = x-y

	iload q
	bipush 1
	iadd
	istore q	// q = q+1
	goto NEGXNEGY	// }


END_WHILE:
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
