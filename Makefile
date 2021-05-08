.PHONY: all install-mathjax install-katex

all: install-mathjax install-katex
	@:

STATIC_LIB := static/lib

MATHJAX_SRC := MathJax/es5
MATHJAX_DST := ${STATIC_LIB}/mathjax

install-mathjax: | MathJax
	@grep version MathJax/package.json
	mkdir -p ${MATHJAX_DST}
	rsync -auv ${MATHJAX_SRC}/tex-chtml.js ${MATHJAX_DST}/
	rsync -auv ${MATHJAX_SRC}/input/tex ${MATHJAX_DST}/input/
	rsync -auv ${MATHJAX_SRC}/output/chtml ${MATHJAX_DST}/output/

MathJax:
	git submodule update --init --recursive

KATEX_DST := ${STATIC_LIB}/katex

install-katex: | katex
	@grep 'version:' katex/katex.js
	mkdir -p ${KATEX_DST}
	rsync -auv katex/katex.min.{css,js} ${KATEX_DST}/
	rsync -auv katex/fonts ${KATEX_DST}/
	rsync -auv katex/contrib/auto-render.min.js ${KATEX_DST}/contrib/

katex:
	curl -L https://github.com/KaTeX/KaTeX/releases/download/v0.13.9/katex.tar.gz | tar xz
