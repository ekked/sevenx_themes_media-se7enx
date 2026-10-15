<?php /* #?ini charset="utf-8"?

# The media theme's content keeps the ids of the media site demo it was imported from: enhanced links and
# layout components store that id, and the theme resolves it as the object with the remote id
# media-o-<id+776>, then media-o-<id>, then the object <id+776>
# (sevenxThemesMediaOperators::enhancedLink(), componentContent()). The kernel's content checks
# (contentcheck.ini [ReferenceSettings], Exponential 6.0.15 and later) resolve them the same way, so a
# fresh installation of the theme reports no false broken links. %id is the stored id, %id+N the id
# moved by N.
[ReferenceSettings]
ImportedIdRemotePatterns[]
ImportedIdRemotePatterns[]=media-o-%id+776
ImportedIdRemotePatterns[]=media-o-%id
ImportedIdObjectPatterns[]
ImportedIdObjectPatterns[]=%id+776

*/ ?>
