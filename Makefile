.PHONY: all install-mathjax install-katex iconify

all: install-mathjax install-katex iconify
	@:

SRC_DIR := assets/src
STATIC_LIB := static/lib

MATHJAX_SRC := ${SRC_DIR}/MathJax
MATHJAX_OUTPUT := ${STATIC_LIB}/mathjax/output

install-mathjax: | ${SRC_DIR}/tex-chtml.js ${MATHJAX_OUTPUT}
	grep version ${MATHJAX_SRC}/package.json

${SRC_DIR}/tex-chtml.js: | ${MATHJAX_SRC}
	cp -p ${MATHJAX_SRC}/es5/tex-chtml.js $@

${MATHJAX_OUTPUT}: | ${MATHJAX_SRC}
	mkdir -p $@
	rsync -auv --delete ${MATHJAX_SRC}/es5/output/chtml $@

${MATHJAX_SRC}:
	git submodule update --init --recursive

KATEX_DST := ${STATIC_LIB}/katex

install-katex: | ${KATEX_DST}/fonts
	grep 'version =' ${SRC_DIR}/katex/katex.mjs

${KATEX_DST}/fonts: | ${SRC_DIR}/katex/fonts
	mkdir -p ${KATEX_DST}
	rsync -auv --delete ${SRC_DIR}/katex/fonts/*.woff2 $@

${SRC_DIR}/katex/fonts:
	curl -L https://github.com/KaTeX/KaTeX/releases/download/v0.16.22/katex.tar.gz | tar xz -C "${SRC_DIR}"

iconify: ${SRC_DIR}/iconify-icon.mjs iconify-css
	grep @version $<

iconify-css:
	python -m wtl.iconify -v -o ${SRC_DIR}/iconify _utils/iconify.toml

${SRC_DIR}/iconify-icon.mjs:
	curl -o $@ https://raw.githubusercontent.com/iconify/code/gh-pages/iconify-icon/3.0.0/iconify-icon.mjs
