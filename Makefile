.PHONY: all mathjax katex

all: mathjax katex
	@:

STATIC_LIB := static/lib

MATHJAX_SRC := MathJax/es5
MATHJAX_DST := ${STATIC_LIB}/mathjax

mathjax:
	mkdir -p ${MATHJAX_DST}
	rsync -auv ${MATHJAX_SRC}/tex-chtml.js ${MATHJAX_DST}/
	rsync -auv ${MATHJAX_SRC}/input/tex ${MATHJAX_DST}/input/
	rsync -auv ${MATHJAX_SRC}/output/chtml ${MATHJAX_DST}/output/

# wget -O- https://github.com/KaTeX/KaTeX/releases/download/v0.13.2/katex.tar.gz | tar xz

KATEX_SRC := katex
KATEX_DST := ${STATIC_LIB}/katex

katex:
	mkdir -p ${KATEX_DST}
	rsync -auv ${KATEX_SRC}/katex.min.{css,js} ${KATEX_DST}/
	rsync -auv ${KATEX_SRC}/fonts ${KATEX_DST}/
	rsync -auv ${KATEX_SRC}/contrib/auto-render.min.js ${KATEX_DST}/contrib/
