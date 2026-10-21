# sevenx_themes_media changelog

## 1.5.75 (2026-10-21)

- Fixed: A layout mapping with a Route target applies on the media pages that
  are not content pages (search, user, a module of an extension). The
  pagelayout laid out content pages only, so a Route mapping never showed;
  on its other pages it now asks `fetch( 'explayouts', 'resolve_route_layout',
  hash() )`, which answers only for a rule with a Route target that names the
  page's module view (`content/search`, `user/*`). The path rules and the
  catch-all keep to content pages, as before. Needs explayouts 1.4.42.

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
