<?php /* #?ini charset="utf-8"?

# Defaults for every media siteaccess; a siteaccess's own menu.ini may override them.
# ezini() with constant arguments is read when a template is compiled, so a setting
# that is missing logs "No such variable" even where the template checks
# ezini_hasvariable() first; giving both a default keeps those reads quiet.
[SiteInfo]
# The cookie policy version (pagelayout/cookie_control.tpl); raise it to ask visitors again.
CookieConsentVersion=1
# The remote id of the folder whose links form the second footer line (pagelayout/footer.tpl).
FooterLinksRemoteID=media-o-footer-links
# A visible license notice of the page below every page ("© 2026 Holder · Licensed
# under CC BY 4.0"), from pagelayout.tpl with design:xrowmetadata/license_notice.tpl
# (xrowmetadata 1.4.9 and later). enabled or disabled.
ShowLicenseNotice=disabled

# The header's user button and its menu (pagelayout/header/user_menu.tpl), on phones and
# desktops alike. Signed out it lists Sign in, Register, the basket, the sitemap and the tag
# cloud; signed in the user's own pages (My profile, Edit profile, Change password), the
# basket, the administration, the sitemap, the tag cloud and Sign out. Each entry is shown
# only when the user may open it.
[HeaderUserMenu]
# enabled or disabled: the user button itself.
UserMenu=enabled
# The basket entry (shop/basket).
#   auto      (the default) shown when the user may use the shop (the shop/buy policy,
#             which shop/basket requires): an installation without a shop grants it to
#             nobody, so the entry stays away until a shop is set up and its roles allow it.
#   disabled  never shown, also where a shop is installed.
ShowBasket=auto
# The Register entry (user/register) for signed-out visitors.
#   auto      (the default) shown when the anonymous user may register (the user/register
#             policy); an installation that closes registration removes that policy, and the
#             entry goes with it.
#   disabled  never shown.
ShowRegister=auto
# The administrations the menu links to, first match wins: the entry "Administration"
# appears for a signed-in user who may log in to one of them (user/login with its
# SiteAccess limitation), with the address siteaccess_href() builds for /<name>/ (the
# siteaccess path under URI matching, else its own address; siteaccess_url() when neither
# applies). Empty: no entry.
AdminSiteAccessList[]
AdminSiteAccessList[]=admin
# enabled or disabled: the sitemap (content/view/sitemap/<root node>) and the tag cloud
# (content/view/tagcloud/<root node>) entries.
ShowSitemap=enabled
ShowTagCloud=enabled

# The next steps below the message of the account result pages (user/success after a
# registration, user/activate after the activation link; user/result_page.tpl). They use the
# entries and settings of [HeaderUserMenu] (Sign in, My profile, Edit profile, the sitemap,
# the tag cloud, the administration) and add Home and Contact.
[UserResultMenu]
# The Contact entry:
#   auto      (the default) the first node of ContactClassList below the content root that the
#             user may read; none found, no entry.
#   disabled  never shown.
#   /path     this address (a URL alias or a module path).
ContactURL=auto
ContactClassList[]
ContactClassList[]=ng_contact_form
ContactClassList[]=feedback_form

*/ ?>
