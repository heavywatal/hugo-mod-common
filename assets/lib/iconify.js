import '../src/iconify-icon.mjs';
const rule = `
iconify-icon {
  display: inline-block;
  min-width: 1em;
  min-height: 1em;
}
`
const sheet = new CSSStyleSheet();
sheet.replaceSync(rule);
document.adoptedStyleSheets.push(sheet);
