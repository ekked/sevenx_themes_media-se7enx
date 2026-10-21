# sevenx_themes_media changelog

## 1.5.74 (2026-10-21)

- Fixed: The media design loads the stylesheets other extensions add to
  `design.ini [StylesheetSettings] CSSFileList[]` and
  `FrontendCSSFileList[]`. They used to be ignored, because the pagelayout
  listed its stylesheets in `pagelayout/head/style.tpl` only. They now load
  after the theme's own files, in the same ezcss_load packer bundle, each
  file once.
- Updated: The theme's dead `CSSFileList[]` entries (`main.css`,
  `main.res.css`, `exponential.css`, `nexus_to_alpha.css`) are replaced by
  `MediaReplacedCSSFileList[]`, which keeps them and the simple theme's base
  styles off the media pages, as before.
