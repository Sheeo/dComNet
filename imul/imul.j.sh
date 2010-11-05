#!/bin/sh
ijvm-asm > gen/imul.bc <<J
// Integer multiplication.
  
.method imul
.args   3			// ( int x, int y )
.define x = 1
.define y = 2		    
.locals 1			// int p;
.define p = 3

	bipush 0
	istore p		// p = 0;

while:				// while 	
	iload x
	iflt end_while
	iload x
	ifeq end_while		//    ( x > 0 ) {
	iload x
	bipush 1
	isub
	istore x		//    x = x - 1;
	iload p
	iload y
	iadd
	istore p		//    p = p + y;
	goto while		// }
end_while:
	iload  p
	ireturn			// return p;

.method main
.args   1
.define OBJREF = 44
  
	bipush OBJREF
	bipush $1
	bipush $2
	invokevirtual imul	
	ireturn			// return imul(2,3);
J
ijvm gen/imul.bc
# vim:ts=8:sw=8:sts=8:
