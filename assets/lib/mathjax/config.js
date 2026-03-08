import * as params from "@params";
window.MathJax = {
  tex: {
    inlineMath: [
      ["$", "$"],
      ["\\(", "\\)"],
    ],
    displayMath: [["\\[", "\\]"]],
    tags: "ams",
  },
  output: {
    scale: 1.0,
    displayAlign: "left",
    displayIndent: "2em",
  },
  chtml: {
    matchFontHeight: false,
  },
  loader: {
    paths: {
      fonts: `${params.rel_lib}/@mathjax`,
    },
  },
  options: {
    enableMenu: false,
    menuOptions: {
      settings: {
        enrich: false,
        speech: false,
        braille: false,
      },
    },
  },
};
