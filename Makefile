.PHONY: all install-mathjax install-katex iconify

all: install-mathjax install-katex iconify
	@:

SRC_DIR := assets/src
STATIC_LIB := static/lib

MATHJAX_SRC := MathJax/es5
MATHJAX_OUTPUT := ${STATIC_LIB}/mathjax/output

install-mathjax: | MathJax
	@grep version MathJax/package.json
	mkdir -p ${MATHJAX_OUTPUT}
	rsync -auv --delete ${MATHJAX_SRC}/tex-chtml.js ${SRC_DIR}/
	rsync -auv --delete ${MATHJAX_SRC}/output/chtml ${MATHJAX_OUTPUT}

MathJax:
	git submodule update --init --recursive

KATEX_DST := ${STATIC_LIB}/katex

install-katex: | ${SRC_DIR}/katex
	@grep 'version:' ${SRC_DIR}/katex/katex.js
	mkdir -p ${KATEX_DST}
	rsync -auv --delete ${SRC_DIR}/katex/fonts/*.woff2 ${KATEX_DST}/fonts/

${SRC_DIR}/katex:
	curl -L https://github.com/KaTeX/KaTeX/releases/download/v0.16.11/katex.tar.gz | tar xz -C "${SRC_DIR}"

iconify: ${SRC_DIR}/iconify-icon.mjs
	@grep @version $<

${SRC_DIR}/iconify-icon.mjs:
	curl -o $@ https://raw.githubusercontent.com/iconify/code/gh-pages/iconify-icon/2.1.0/iconify-icon.mjs
