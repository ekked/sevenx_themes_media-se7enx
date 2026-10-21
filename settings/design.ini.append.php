<?php /* #?ini charset="utf-8"?

[ExtensionSettings]
DesignExtensions[]=sevenx_themes_media

[StylesheetSettings]
# The media design lists its own stylesheets in
# design/media/templates/pagelayout/head/style.tpl, in the order they must
# load. After them it loads every entry other extensions add to
# CSSFileList[] and FrontendCSSFileList[] (cjw_newsletter.css, eztags.css,
# ezgmaplocation.css ...), through the same ezcss_load packer bundle.
#
# MediaReplacedCSSFileList[] names the CSSFileList entries the media design
# replaces and must never load: the simple theme's base styles (the media
# design falls back to it for templates, not for CSS) and the theme's
# retired stylesheets. Add a file here to keep it off the media pages; reset
# the list (MediaReplacedCSSFileList[] on its own line) to load everything.
MediaReplacedCSSFileList[]
MediaReplacedCSSFileList[]=websitetoolbar.css
MediaReplacedCSSFileList[]=libs/fontawesome/css/all.min.css
MediaReplacedCSSFileList[]=magnific-popup.css
MediaReplacedCSSFileList[]=main.css
MediaReplacedCSSFileList[]=main.res.css
MediaReplacedCSSFileList[]=exponential.css
MediaReplacedCSSFileList[]=nexus_to_alpha.css

*/ ?>
