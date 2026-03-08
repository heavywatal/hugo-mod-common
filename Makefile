.PHONY: all install-mathjax install-katex iconify

all: install-mathjax install-katex iconify
	@:

SRC_DIR := assets/src
STATIC_LIB := static/lib

MATHJAX_JS := mathjax/tex-chtml.js
MATHJAX_FONT := @mathjax/mathjax-newcm-font/chtml/woff2

install-mathjax: ${SRC_DIR}/${MATHJAX_JS} ${SRC_DIR}/${MATHJAX_FONT}
	@:

${SRC_DIR}/${MATHJAX_JS}: node_modules/${MATHJAX_JS}
	rsync -auv --delete $(dir $<)/ $(dir $@)

${SRC_DIR}/${MATHJAX_FONT}: node_modules/${MATHJAX_FONT}
	mkdir -p $(dir $@)
	rsync -auv --delete $</ $@

node_modules/${MATHJAX_JS} node_modules/${MATHJAX_FONT}:
	pnpm install

KATEX_DST := ${STATIC_LIB}/katex

install-katex: | ${KATEX_DST}/fonts
	grep 'version =' ${SRC_DIR}/katex/katex.mjs

${KATEX_DST}/fonts: | ${SRC_DIR}/katex/fonts
	mkdir -p ${KATEX_DST}
	rsync -auv --delete ${SRC_DIR}/katex/fonts/*.woff2 $@

${SRC_DIR}/katex/fonts:
	curl -L https://github.com/KaTeX/KaTeX/releases/download/v0.16.37/katex.tar.gz | tar xz -C "${SRC_DIR}"

clean-katex:
	rm -rf ${KATEX_DST} ${SRC_DIR}/katex

iconify: ${SRC_DIR}/iconify-icon.mjs iconify-css
	grep @version $<

iconify-css:
	python -m wtl.iconify -v -o ${SRC_DIR}/iconify _utils/iconify.toml

${SRC_DIR}/iconify-icon.mjs:
	curl -fL -o $@ https://raw.githubusercontent.com/iconify/code/gh-pages/iconify-icon/3.0.2/iconify-icon.mjs
