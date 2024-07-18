import '../src/iconify-icon.mjs';
const rule = `
iconify-icon {
  display: inline-block;
  vertical-align: -0.125em;
  width: 1em;
  height: 1em;
}
`
const sheet = new CSSStyleSheet();
sheet.replaceSync(rule);
document.adoptedStyleSheets.push(sheet);
