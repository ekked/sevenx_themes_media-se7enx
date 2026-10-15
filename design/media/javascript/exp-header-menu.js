/*
 * The header's user menu and its share of the header search (pagelayout/header/user_menu.tpl and search_box.tpl).
 *
 * The user menu is a disclosure, as the administration's user menu is: the button's aria-expanded says whether the
 * panel is shown, a click toggles it, ArrowDown on the button opens it with the focus on the first link, ArrowDown,
 * ArrowUp, Home and End move between the links (ArrowUp from the first goes back to the button), Escape closes it
 * and gives the focus back to the button, and a click outside it or the focus leaving it closes it.
 *
 * The search form is opened by the design's header script (the class searchbox-active on <html>). This file adds
 * what it lacks: Escape closes the search and gives the focus back to its button, and the button's aria-expanded
 * follows the class also when something else removes it (the main menu button does).
 *
 * One header menu at a time: opening the user menu closes the search and the main menu; opening the search or the
 * main menu closes the user menu.
 */
(function () {
    'use strict';

    var root = document.documentElement;
    var SEARCH_OPEN = 'searchbox-active';
    var NAV_OPEN = 'mainnav-active';

    function init() {
        var header = document.querySelector('.site-header');
        if (!header) return;
        var searchButton = header.querySelector('.searchbox-toggle');
        var navButton = header.querySelector('.mainnav-toggle');
        var userButton = document.getElementById('header-user-toggle');
        var panel = document.getElementById('header-user-menu');
        var wrap = userButton ? userButton.parentNode : null;

        function links() {
            return panel ? Array.prototype.filter.call(panel.querySelectorAll('a[href]'), function (a) {
                return a.offsetParent !== null;
            }) : [];
        }

        function userOpen() {
            return !!userButton && userButton.getAttribute('aria-expanded') === 'true';
        }

        function setUser(state, focusButton) {
            if (!userButton || !panel) return;
            userButton.setAttribute('aria-expanded', state ? 'true' : 'false');
            panel.hidden = !state;
            if (state) {
                closeSearch(false);
                root.classList.remove(NAV_OPEN);
                if (navButton) navButton.setAttribute('aria-expanded', 'false');
            } else if (focusButton) {
                userButton.focus();
            }
        }

        function closeSearch(focusButton) {
            root.classList.remove(SEARCH_OPEN);
            if (searchButton) {
                searchButton.setAttribute('aria-expanded', 'false');
                if (focusButton) searchButton.focus();
            }
        }

        // the search button's state follows the class, whoever changes it
        if (searchButton && window.MutationObserver) {
            new MutationObserver(function () {
                var open = root.classList.contains(SEARCH_OPEN);
                if ((searchButton.getAttribute('aria-expanded') === 'true') !== open) {
                    searchButton.setAttribute('aria-expanded', open ? 'true' : 'false');
                }
            }).observe(root, { attributes: true, attributeFilter: ['class'] });
        }
        if (searchButton) {
            searchButton.addEventListener('click', function () {
                if (userOpen()) setUser(false, false);
            });
        }

        if (userButton && panel) {
            userButton.addEventListener('click', function () {
                setUser(!userOpen(), false);
            });
            userButton.addEventListener('keydown', function (e) {
                if (e.key !== 'ArrowDown') return;
                e.preventDefault();
                setUser(true, false);
                var first = links()[0];
                if (first) first.focus();
            });
            panel.addEventListener('keydown', function (e) {
                var list = links(), i = list.indexOf(document.activeElement), next = null;
                if (e.key === 'ArrowDown') next = list[Math.min(list.length - 1, i + 1)];
                else if (e.key === 'ArrowUp') next = i <= 0 ? null : list[i - 1];
                else if (e.key === 'Home') next = list[0];
                else if (e.key === 'End') next = list[list.length - 1];
                else return;
                e.preventDefault();
                if (next) next.focus(); else if (e.key === 'ArrowUp') userButton.focus();
            });
            wrap.addEventListener('focusout', function (e) {
                if (userOpen() && e.relatedTarget && !wrap.contains(e.relatedTarget)) setUser(false, false);
            });
            document.addEventListener('click', function (e) {
                if (userOpen() && !wrap.contains(e.target)) setUser(false, false);
            });
        }

        document.addEventListener('keydown', function (e) {
            if (e.key !== 'Escape' || e.defaultPrevented) return;
            var active = document.activeElement;
            if (userOpen()) {
                e.preventDefault();
                setUser(false, active === userButton || panel.contains(active));
                return;
            }
            if (root.classList.contains(SEARCH_OPEN)) {
                var search = searchButton ? searchButton.closest('.header-search') : null;
                e.preventDefault();
                closeSearch(!!search && search.contains(active));
            }
        });
    }

    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
    else init();
})();
