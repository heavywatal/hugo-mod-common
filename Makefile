.PHONY: all install-mathjax install-katex iconify

all: install-mathjax install-katex iconify
	@:

SRC_DIR := assets/src

MATHJAX_JS := mathjax/tex-chtml.js
MATHJAX_FONT := @mathjax/mathjax-newcm-font/chtml/woff2

install-mathjax: ${SRC_DIR}/${MATHJAX_JS} ${SRC_DIR}/${MATHJAX_FONT}
	@:

${SRC_DIR}/${MATHJAX_JS}: node_modules/${MATHJAX_JS}
	rsync -auv --delete $(dir $<)/ $(dir $@)

${SRC_DIR}/${MATHJAX_FONT}: node_modules/${MATHJAX_FONT}
	mkdir -p $(dir $@)
	rsync -auv --delete $</ $@

node_modules/${MATHJAX_JS} node_modules/${MATHJAX_FONT} node_modules/katex/dist/katex.mjs:
	pnpm install

install-katex: ${SRC_DIR}/katex/katex.mjs
	grep 'version =' $<

${SRC_DIR}/katex/katex.mjs: node_modules/katex/dist/katex.mjs
	rsync -auvC --delete $(dir $<)/ $(dir $@)

clean-katex:
	rm -rf ${SRC_DIR}/katex

iconify: ${SRC_DIR}/iconify-icon.mjs iconify-css
	grep @version $<

iconify-css:
	python -m wtl.iconify -v -o ${SRC_DIR}/iconify _utils/iconify.toml

${SRC_DIR}/iconify-icon.mjs:
	curl -fL -o $@ https://raw.githubusercontent.com/iconify/code/gh-pages/iconify-icon/3.0.2/iconify-icon.mjs
