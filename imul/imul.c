/* Integer multiplication. */

#include <stdio.h>

int imul(int x, int y)
{ int p;
  
  p = 0;
  while ( x > 0 ) {
    x = x - 1;
    p = p + y;
  }
  return p;
}

int main(int argc, char *argv[])
{ 
  printf("imul(%d,%d) = %d.\n",2,3, imul(2,3));
}
