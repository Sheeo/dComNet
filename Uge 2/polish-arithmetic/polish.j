// Integer multiplication.
  
.method imul
.args   3			// ( int x, int y )
.define x = 1
.define y = 2		    
.locals 3			// int p, sub, mask;
.define p = 3
.define sub = 4
.define mask = 5

	bipush 0
	istore p		// p = 0;
	bipush 1
	istore sub              // sub = 1;
	bipush 1
	istore mask             // mask = 1;

	// find |x|
	bipush 0
	iload x
	dup
	iflt then3
	goto else3
then3:
	isub // negate x
	goto endif3
else3:
	iadd // swallow 0
endif3:

	// find |y|
	bipush 0
	iload y
	dup
	iflt then2
	goto else2
then2:
	isub // negate y
	goto endif2
else2:
	iadd // swallow the zero
endif2:
	// stack now contains |x|, |y|

	isub
	dup
	iflt post_swap
	ifeq post_swap          // if (x > y)
	iload x
	iload y
	istore x
	istore y                //    x ^= y ^= x ^= y; // (swap x and y) 
post_swap:


	iload x
	iflt then
	goto endif
then:
	bipush 0
	iload x
	isub
	istore x
	bipush 0
	iload y
	isub
	istore y
endif:

while:				// while 	
	iload x
	iflt end_while
	iload x
	ifeq end_while		//    ( x > 0 ) {
	iload x
	iload mask
	iand
	ifeq incrsub            //    if (x & mask != 0) {
	goto post_incrsub
incrsub:
	iload sub
	dup
	iadd
	dup
	istore sub              //       sub += sub;
	iload mask
	ior
	istore mask             //       mask |= sub;
	iload y
	dup
	iadd
	istore y                //       y += y;
post_incrsub:                   //    }
	iload x
	iload sub
	isub
	istore x		//    x = x - sub;
	iload p
	iload y
	iadd
	istore p		//    p = p + y;
	goto while		// }
end_while:
	iload  p
	ireturn			// return p;

.method idiv	// int idiv(int x, int y)
.args 3
.locals 1
.define x = 1
.define y = 2
.define q = 3	// int q;
	
	iload y
	ifeq END_IDIVWHILE	// if y == 0, exit
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
	iflt END_IDIVWHILE	// while (x >= y) {
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
	iflt END_IDIVWHILE	// while (x >= -y) {
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
	goto END_IDIVWHILE	// while (x <= -y) {

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
	goto END_IDIVWHILE	// while (x <= y) {
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


END_IDIVWHILE:
	iload q
	ireturn		// return q

.method main
.args 1
.locals 2
.define to1 = 1
.define to2 = 2
	bipush 8
	bipush 120 // objref
	bipush 2
	bipush 5
	invokevirtual imul
	iadd
	bipush 1
	bipush 120 // objref
	bipush 3
	bipush 2
	invokevirtual imul
	iadd
	bipush 4
	isub
	istore to1
	istore to2
	bipush 120 // objref
	iload to2
	iload to1
	invokevirtual idiv
	ireturn

// vim:syntax=bytecode:
