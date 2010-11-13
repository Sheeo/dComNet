#include <stdio.h> // fprintf
#include <stdlib.h> // strtol

int idiv(int x, int y) { 
	int q;
	q = 0;
	while ( x >= y ) {
		x = x - y;
		q = q + 1;
	}
	while ( x <= -y ) {
		x = x + y;
		q = q - 1;
	}
	return q;
}

int usage(const char *prog) {
	fprintf(stderr, "usage: %s x y\n", prog);
	fprintf(stderr, "returns the integer part of the quotient x/y\n");
	return 1;
}

int main(int argc, char *argv[]) {
	if (argc < 3 || !*argv[1] || !*argv[2]) return usage(argv[0]);
	char *c;
	int x = strtol(argv[1], &c, 0);
	if (c == NULL) return usage(argv[0]);
	int y = strtol(argv[2], &c, 0);
	if (c == NULL) return usage(argv[0]);
	int res = idiv(x, y);
	printf("idiv(%d, %d) = %d.\n", x, y, res);
	if (res != x/y) {
		fprintf(stderr, "warning: %d = idiv(%d, %d) != %2$d/%3$d = %d\n", res, x, y, x/y);
		return 1;
	}
	return 0;
}
