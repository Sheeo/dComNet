#include <stdio.h>
#include <stdlib.h>

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
  if (x < 0) {
    x = -x;
    y = -y;
  }
  while ( x != 0 ) {
    if (x & mask == 0) {
      sub += sub;
      mask |= sub;
      y += y;
    }
    x = x - sub;
    p = p + y;
  }
  return p;
}

int main(int argc, char *argv[]) { 
#define usage() {printf("usage: %s x y\n", argv[0]); return 1;}
  int x,y;
  char *p;
  if (argc < 3 || !*argv[1] || !*argv[2]) {usage();}
  x = strtol(argv[1], &p, 0);
  if (*p) {usage();}
  y = strtol(argv[2], &p, 0);
  if (*p) {usage();}
  int res = imul(x,y);
  printf("imul(%d,%d) = %d.\n",x,y,res);
  return 2*(x*y!=res); // return 2 if res is incorrect
}
/* vim:sw=2:ts=2:sts=2:et:
 */
