.PHONY: mathjax

MATHJAX_SRC := MathJax/es5
MATHJAX_DST := static/lib/mathjax

mathjax:
	mkdir -p ${MATHJAX_DST}
	rsync -auv ${MATHJAX_SRC}/tex-chtml.js ${MATHJAX_DST}/
	rsync -auv ${MATHJAX_SRC}/input/tex ${MATHJAX_DST}/input/
	rsync -auv ${MATHJAX_SRC}/output/chtml ${MATHJAX_DST}/output/
