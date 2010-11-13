.method imul     // int imul(int x, int y) {
.args 3
.locals 2
.define x = 1
.define y = 2
.define r = 3    // int r;
.define sign = 4 // int sign;

  bipush 0
  istore r       // r = 0;

  bipush 1
  istore sign    // sign = 0;

  iload x
  iflt THEN
  goto ENDIF

THEN:            // if (x < 0) {
  bipush 0
  iload x
  isub
  istore x       //   x = -x;

  bipush 0
  istore sign    //   sign = 0;

ENDIF:           // }
WHILE:
  iload x dup
  iflt ENDWHILE
  ifeq ENDWHILE  // while (x > 0) {

  iload x
  bipush 1
  isub
  istore x       //   --x;

  iload r
  iload y
  iadd
  istore r       //   r += y;

  goto WHILE     // }

ENDWHILE:
  iload sign
  ifeq THEN2
  goto ENDIF2    // if (sign == 0) {

THEN2:
  bipush 0
  iload r
  isub
  istore r       //   r = -r;

ENDIF2:          // }
  iload r
  ireturn        // return r;

.method main
.args 3
  bipush 120 // objref
  iload 1
  iload 2
  invokevirtual imul
  ireturn
