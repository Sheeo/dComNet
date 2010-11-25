all: test.trace

aflevering.pdf: aflevering.tex
	pdflatex aflevering.tex

ijvm.mic1: ijvm.mal
	mic1-asm ijvm.mal ijvm.mic1

test.bc: test.j
	ijvm-asm test.j test.bc

test.trace: test.bc ijvm.mic1
	mic1 ijvm.mic1 test.bc | tee test.trace
