{* The page after the link of the activation mail (user/activate) in the media design: the outcome and the next
   steps, drawn by user/result_page.tpl. The view passes $account_activated (the key was valid), $is_pending (an
   administrator still has to approve the account) and $already_active (no key, but the account is active). *}
{include uri='design:user/result_page.tpl' result_user=false()
         result_state=cond( $account_activated, cond( $is_pending, 'activated_pending', 'activated' ),
                            $already_active, 'already_active',
                            'invalid_key' )}
