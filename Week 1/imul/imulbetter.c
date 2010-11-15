/* Integer multiplication. */

#include <stdio.h>

int imul(int x, int y)
{ int p, sub, mask;

  p = 0;
  sub = 1;
  mask = 1;
  if (x > y) {
    x ^= y;
    y ^= x;
    x ^= y;
  }
  while ( x > 0 ) {
    if (x & mask != 0) {
      sub += sub;
      mask |= sub;
      y += y;
    }
    x = x - sub;
    p = p + y;
  }
  return p;
}

int main(int argc, char *argv[])
{ 
  printf("imul(%d,%d) = %d.\n",0x4000,0x4000, imul(0x4000,0x4000));
}
/* vim:sw=2:ts=2:sts=2:et:
 */
