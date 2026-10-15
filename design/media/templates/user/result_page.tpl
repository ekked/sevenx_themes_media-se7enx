{* The result page of the account views in the media design: user/success (after a registration) and user/activate
   (after the link of the activation mail). Included by user/success.tpl and user/activate.tpl with

     result_state   verify_email, pending_approval, active, signed_in, activated, activated_pending,
                    already_active, invalid_key or error
     result_user    the account of the registration (an eZUser), or false

   The page header names the outcome; the message below it is a live region (role="status", role="alert" for the
   errors), so it is read out when the page opens. After it comes the navigation of next steps, a nav with its own
   heading as name, chosen by the state and the user's policies with the logic and the labels of the header's user
   menu (pagelayout/header/user_menu.tpl, menu.ini [HeaderUserMenu]):

     Sign in           not signed in, and the account is active (or the state is unknown to this page)
     My profile        signed in, and user/edit is allowed
     Edit profile      signed in, and the user may edit the own account
     Register          the registration failed and the anonymous user may register
     Home, Sitemap, Tag cloud   always (the sitemap and the tag cloud as [HeaderUserMenu] ShowSitemap, ShowTagCloud)
     Contact           when the site has a contact form (menu.ini [UserResultMenu])
     Administration    signed in, and the user may log in to an administration of [HeaderUserMenu] AdminSiteAccessList

   There is no public way to send the activation mail again (only Users > Unactivated users in the administration),
   so the page offers none. Every link carries data-exp-rn, the name of the entry, for the browser checks.
   Drawn by stylesheets/account.css (.acc-result). *}
{def $rp_state = cond( is_set( $result_state ), $result_state, 'active' )
     $rp_user = cond( and( is_set( $result_user ), $result_user ), $result_user, false() )
     $rp_current = fetch( 'user', 'current_user' )
     $rp_signed_in = $rp_current.is_logged_in
     $rp_root = ezini( 'NodeSettings', 'RootNode', 'content.ini' )
     $rp_email = ''
     $rp_name = ''
     $rp_title = ''
     $rp_texts = array()
     $rp_tone = 'success'
     $rp_role = 'status'
     $rp_admin_url = ''
     $rp_contact_url = ''
     $rp_contact_setting = cond( ezini_hasvariable( 'UserResultMenu', 'ContactURL', 'menu.ini' ), ezini( 'UserResultMenu', 'ContactURL', 'menu.ini' ), 'auto' )
     $rp_contact_nodes = false()}
{if $rp_user}
    {set $rp_email = $rp_user.email
         $rp_name = cond( $rp_user.contentobject, $rp_user.contentobject.name, $rp_user.login )}
{elseif $rp_signed_in}
    {set $rp_name = $rp_current.contentobject.name}
{/if}

{switch match=$rp_state}
{case match='verify_email'}
    {set $rp_title = 'Check your e-mail'|i18n( 'design/media/user' )
         $rp_tone = 'info'}
    {set $rp_texts = $rp_texts|append( 'Your account has been created. One step is left: confirm your e-mail address.'|i18n( 'design/media/user' ) )}
    {if $rp_email}
        {set $rp_texts = $rp_texts|append( 'We sent a message to %email. Open the link in it to activate your account; then you can sign in.'|i18n( 'design/media/user',, hash( '%email', $rp_email ) ) )}
    {else}
        {set $rp_texts = $rp_texts|append( 'We sent a message to the e-mail address you entered. Open the link in it to activate your account; then you can sign in.'|i18n( 'design/media/user' ) )}
    {/if}
    {set $rp_texts = $rp_texts|append( 'No message after a few minutes? Look in your spam folder.'|i18n( 'design/media/user' ) )}
{/case}
{case match='pending_approval'}
    {set $rp_title = 'Your account is waiting for approval'|i18n( 'design/media/user' )
         $rp_tone = 'warning'
         $rp_texts = array( 'Your account has been created. An administrator checks new accounts before they can be used.'|i18n( 'design/media/user' ),
                            'You will get an e-mail as soon as your account is approved; then you can sign in.'|i18n( 'design/media/user' ) )}
{/case}
{case match='signed_in'}
    {set $rp_title = cond( $rp_name, 'Welcome, %name'|i18n( 'design/media/user',, hash( '%name', $rp_name ) ), 'Welcome'|i18n( 'design/media/user' ) )
         $rp_texts = array( 'Your account is ready and you are signed in.'|i18n( 'design/media/user' ) )}
{/case}
{case match='activated'}
    {set $rp_title = 'Your e-mail address is confirmed'|i18n( 'design/media/user' )
         $rp_texts = array( cond( $rp_signed_in, 'Your account is active and you are signed in.'|i18n( 'design/media/user' ), 'Your account is active. You can sign in now.'|i18n( 'design/media/user' ) ) )}
{/case}
{case match='activated_pending'}
    {set $rp_title = 'Your e-mail address is confirmed'|i18n( 'design/media/user' )
         $rp_tone = 'warning'
         $rp_texts = array( 'An administrator checks new accounts before they can be used.'|i18n( 'design/media/user' ),
                            'You will get an e-mail as soon as your account is approved; then you can sign in.'|i18n( 'design/media/user' ) )}
{/case}
{case match='already_active'}
    {set $rp_title = 'Your account is already active'|i18n( 'design/media/user' )
         $rp_tone = 'info'
         $rp_texts = array( cond( $rp_signed_in, 'You are signed in.'|i18n( 'design/media/user' ), 'The account was activated before. You can sign in.'|i18n( 'design/media/user' ) ) )}
{/case}
{case match='invalid_key'}
    {set $rp_title = 'This activation link does not work'|i18n( 'design/media/user' )
         $rp_tone = 'error'
         $rp_role = 'alert'
         $rp_texts = array( 'The link is not valid, or it has been used already. Your account was not activated.'|i18n( 'design/media/user' ),
                            'Copy the whole link from the e-mail into the address bar of your browser. If you activated the account before, sign in.'|i18n( 'design/media/user' ) )}
{/case}
{case match='error'}
    {set $rp_title = 'We could not find your account'|i18n( 'design/media/user' )
         $rp_tone = 'error'
         $rp_role = 'alert'
         $rp_texts = array( 'The account of this registration does not exist (any more).'|i18n( 'design/media/user' ),
                            'Please register again, or contact us if the problem stays.'|i18n( 'design/media/user' ) )}
{/case}
{case}
    {set $rp_state = 'active'
         $rp_title = 'Your account is ready'|i18n( 'design/media/user' )
         $rp_texts = array( cond( $rp_signed_in, 'Your account has been created and you are signed in.'|i18n( 'design/media/user' ), 'Your account has been created. You can sign in now.'|i18n( 'design/media/user' ) ) )}
{/case}
{/switch}

{* Administration: the first of [HeaderUserMenu] AdminSiteAccessList the user may log in to, as in the header *}
{if $rp_signed_in}
    {foreach ezini( 'HeaderUserMenu', 'AdminSiteAccessList', 'menu.ini' ) as $rp_sa}
        {if and( $rp_admin_url|eq( '' ), $rp_sa|ne( '' ), exp_can_login_to_siteaccess( $rp_sa ) )}
            {set $rp_admin_url = siteaccess_href( concat( '/', $rp_sa, '/' ) )}
            {if $rp_admin_url|eq( '' )}{set $rp_admin_url = siteaccess_url( $rp_sa )}{/if}
        {/if}
    {/foreach}
{/if}

{* Contact: menu.ini [UserResultMenu] ContactURL, or (auto) the first contact form the user may read in this site's
   own tree: below the node of site.ini [SiteAccessSettings] PathPrefix when the siteaccess has one, else below the
   content root *}
{if $rp_contact_setting|eq( 'auto' )}
    {if ezini_hasvariable( 'UserResultMenu', 'ContactClassList', 'menu.ini' )}
        {if ezini( 'UserResultMenu', 'ContactClassList', 'menu.ini' )|count}
            {def $rp_contact_parent = $rp_root
                 $rp_prefix = cond( ezini_hasvariable( 'SiteAccessSettings', 'PathPrefix' ), ezini( 'SiteAccessSettings', 'PathPrefix' ), '' )
                 $rp_prefix_node = false()}
            {if $rp_prefix|ne( '' )}
                {set $rp_prefix_node = fetch( 'content', 'node', hash( 'node_path', $rp_prefix ) )}
                {if $rp_prefix_node}{set $rp_contact_parent = $rp_prefix_node.node_id}{/if}
            {/if}
            {set $rp_contact_nodes = fetch( 'content', 'tree', hash( 'parent_node_id', $rp_contact_parent,
                                                                     'class_filter_type', 'include',
                                                                     'class_filter_array', ezini( 'UserResultMenu', 'ContactClassList', 'menu.ini' ),
                                                                     'main_node_only', true(),
                                                                     'sort_by', array( 'path', true() ),
                                                                     'limit', 1 ) )}
            {if $rp_contact_nodes|count}{set $rp_contact_url = $rp_contact_nodes[0].url_alias|ezurl( 'no' )}{/if}
            {undef $rp_contact_parent $rp_prefix $rp_prefix_node}
        {/if}
    {/if}
{elseif and( $rp_contact_setting|ne( '' ), $rp_contact_setting|ne( 'disabled' ) )}
    {set $rp_contact_url = $rp_contact_setting|ezurl( 'no' )}
{/if}

<header class="full-page-header acc-header text-center no-breadcrumbs">
    <div class="container">
        <h1 class="full-page-title" id="user-result-title">{$rp_title|wash}</h1>
    </div>
</header>

<div class="full-form-content acc-content">
    <div class="container acc acc-result" data-exp-result-state="{$rp_state|wash}">
        <div class="acc-notice {$rp_tone} acc-result-message" role="{$rp_role}" aria-atomic="true">
            <div>
            {foreach $rp_texts as $rp_text}
                <p>{$rp_text|wash}</p>
            {/foreach}
            </div>
        </div>

        <nav class="acc-result-nav" aria-labelledby="user-result-next">
            <h2 class="acc-result-nav-title" id="user-result-next">{'What next?'|i18n( 'design/media/user' )}</h2>
            <ul class="acc-result-links">
            {if and( $rp_signed_in|not, $rp_state|ne( 'verify_email' ), $rp_state|ne( 'pending_approval' ), $rp_state|ne( 'activated_pending' ), $rp_state|ne( 'error' ) )}
                <li class="acc-result-primary"><a href={'/user/login'|ezurl} data-exp-rn="login">{'Sign in'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if $rp_signed_in}
                {if fetch( 'user', 'can_open', hash( 'uri', 'user/edit' ) )}
                <li class="acc-result-primary"><a href={'/user/edit'|ezurl} data-exp-rn="profile">{'My profile'|i18n( 'design/media/pagelayout' )}</a></li>
                {/if}
                {if $rp_current.contentobject.can_edit}
                <li><a href={concat( '/content/edit/', $rp_current.contentobject_id, '/' )|ezurl} data-exp-rn="edit">{'Edit profile'|i18n( 'design/media/pagelayout' )}</a></li>
                {/if}
            {/if}
            {if and( $rp_state|eq( 'error' ), $rp_signed_in|not, fetch( 'user', 'can_open', hash( 'uri', 'user/register' ) ) )}
                <li class="acc-result-primary"><a href={'/user/register'|ezurl} data-exp-rn="register">{'Register'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
                <li><a href={'/'|ezurl} data-exp-rn="home">{'Home'|i18n( 'design/media/pagelayout' )}</a></li>
            {if ezini( 'HeaderUserMenu', 'ShowSitemap', 'menu.ini' )|eq( 'enabled' )}
                <li><a href={concat( '/content/view/sitemap/', $rp_root )|ezurl} data-exp-rn="sitemap">{'Sitemap'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if ezini( 'HeaderUserMenu', 'ShowTagCloud', 'menu.ini' )|eq( 'enabled' )}
                <li><a href={concat( '/content/view/tagcloud/', $rp_root )|ezurl} data-exp-rn="tagcloud">{'Tag cloud'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if $rp_contact_url|ne( '' )}
                <li><a href="{$rp_contact_url|wash}" data-exp-rn="contact">{'Contact'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            {if $rp_admin_url|ne( '' )}
                <li><a href="{$rp_admin_url|wash}" data-exp-rn="admin">{'Administration'|i18n( 'design/media/pagelayout' )}</a></li>
            {/if}
            </ul>
        </nav>
    </div>
</div>
{undef $rp_state $rp_user $rp_current $rp_signed_in $rp_root $rp_email $rp_name $rp_title $rp_texts $rp_tone $rp_role
       $rp_admin_url $rp_contact_url $rp_contact_setting $rp_contact_nodes}
