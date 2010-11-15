all: imul wc

clean:
	@(rm -v imul imul.bc imul.trace || true) 2>/dev/null

imul: imul.c
	gcc -o imul imul.c

wc:
	sh imulwc.sh 10 10

aflevering.pdf: aflevering.tex
	texi2pdf aflevering.tex
