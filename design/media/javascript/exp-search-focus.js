/*
 * Initial focus for the pages whose purpose is searching (media design).
 *
 * The error pages that offer the site search (error/parts/page.tpl) and the
 * search results page (content/search.tpl) mark their search field with
 * data-exp-autofocus. When such a page opens, the cursor goes into that field,
 * so a visitor can type at once; Tab then moves on to the buttons after it in
 * their visual order (the DOM order, no tabindex).
 *
 * Only these pages carry the attribute: the search widget in the header is not
 * marked, so no other page takes the focus away from the visitor.
 *
 * Nothing is taken away from the visitor either: when something already has
 * the focus as this runs (the cookie banner, which opens and focuses itself on
 * a first visit, or a field the visitor clicked into), it is left alone, and
 * the field is focused once the banner has been answered instead.
 * preventScroll keeps the page where it is when the field is not at the top.
 *
 * Loaded deferred after exp-cookie-consent.js (pagelayout/head/script.tpl).
 */
(function () {
    'use strict';

    function field() {
        return document.querySelector('input[data-exp-autofocus]');
    }

    function idle() {
        var active = document.activeElement;
        return !active || active === document.body || active === document.documentElement;
    }

    function focusField() {
        var input = field();
        if (!input || !idle()) {
            return;
        }
        try {
            input.focus({ preventScroll: true });
        } catch (e) {
            input.focus();
        }
    }

    function init() {
        if (!field()) {
            return;
        }
        focusField();
        document.addEventListener('exp:cookie-consent', function () {
            window.setTimeout(focusField, 0);
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
}());
