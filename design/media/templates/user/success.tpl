{* The page after a registration (user/success) in the media design: the state of the new account and the next
   steps, drawn by user/result_page.tpl.

   The kernel names the state in $registration_state (verify_email, pending_approval, active, signed_in, error) and
   the account in $registered_user. A kernel older than that passes only $verify_user_email: the state is then
   "signed in" for a signed-in user, else "check your e-mail" or "active" as the settings say. *}
{if is_set( $registration_state )}
    {include uri='design:user/result_page.tpl' result_state=$registration_state result_user=cond( is_set( $registered_user ), $registered_user, false() )}
{else}
    {include uri='design:user/result_page.tpl' result_user=false()
             result_state=cond( fetch( 'user', 'current_user' ).is_logged_in, 'signed_in', and( is_set( $verify_user_email ), $verify_user_email ), 'verify_email', 'active' )}
{/if}
