{* The tour of the demo content (/exponential-live): the page whose object has the remote id showcase-s1-tour. Its
   children (ng_shortcut) are the stops, in priority order: title = headline, teaser_title = where it is,
   teaser_intro = why it matters (first paragraph) and the "try it" links (second paragraph), image = screenshot.
   The speed card after the Velocity stop reads showcase/speed (the last measurement, made by an administrator); it
   is shown only where that module exists, which a default installation does not have. *}
{def $stops = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                              'class_filter_type', 'include', 'class_filter_array', array( 'ng_shortcut' ),
                                              'sort_by', array( 'priority', true() ) ) )
     $speed = ezmodule( 'showcase/speed' )
     $stop_map = false()
     $img = false()
     $no = 0}
<div class="view-type view-type-full exp-tour">

    <header class="exp-tour-hero">
        <div class="container">
            <p class="exp-tour-eyebrow">Exponential, live</p>
            <h1>See Exponential at its best, live on this server</h1>
            <div class="exp-tour-lead">{if $node.data_map.teaser_intro.has_content}{attribute_view_gui attribute=$node.data_map.teaser_intro}{else}<p>A guided tour of Exponential 6 on this server: twelve stops, ten to fifteen minutes, real features and real speed. Every screenshot below is this installation, and every button opens the real thing.</p>{/if}</div>
            <ul class="exp-tour-facts">
                <li><strong>{$stops|count}</strong> stops</li>
                <li><strong>10 to 15</strong> minutes</li>
                <li>Exponential <strong>{fetch( 'setup', 'version' )|wash}</strong></li>
                <li>PHP <strong>8.0 to 8.5</strong></li>
                <li>No mock-ups</li>
            </ul>
            <div class="exp-tour-actions">
                {if $stops|count}<a class="exp-tour-btn is-primary" href="#stop-1">Start the tour</a>{/if}
                {if $speed}<a class="exp-tour-btn" href="#exp-tour-speed">Compare the speed</a>
                {/if}<a class="exp-tour-btn" href="/admin/content/dashboard">Open the admin</a>
            </div>
        </div>
    </header>

    {if $stops|count}
    <nav class="exp-tour-index" aria-label="Stops of the tour">
        <div class="container">
            <ol>
            {foreach $stops as $stop}
                {set $no = $no|inc}
                <li><a href="#stop-{$no}">{$stop.data_map.title.content|wash}</a></li>
            {/foreach}
            </ol>
        </div>
    </nav>
    {/if}

    <div class="container exp-tour-stops">
    {set $no = 0}
    {foreach $stops as $stop}
        {set $no = $no|inc
             $stop_map = $stop.data_map
             $img = false()}
        <section class="exp-tour-stop" id="stop-{$no}" aria-labelledby="stop-{$no}-title">
            {if $stop_map.image.has_content}
                {set $img = $stop_map.image.content}
                <figure class="exp-tour-shot">
                    <a href={$img.original.url|ezroot} target="_blank" rel="noopener" title="Open the screenshot at full size">
                        <img src={$img.i770.url|ezroot}
                             srcset="{$img.i770.url|ezroot( 'no' )} {$img.i770.width}w, {$img.i1320.url|ezroot( 'no' )} {$img.i1320.width}w, {$img.original.url|ezroot( 'no' )} {$img.original.width}w"
                             sizes="(max-width: 991px) 100vw, 58vw"
                             width="{$img.i770.width}" height="{$img.i770.height}"
                             loading="{if $no|le(2)}eager{else}lazy{/if}" alt="Screenshot: {$stop.data_map.title.content|wash}" />
                    </a>
                </figure>
            {else}
                <div class="exp-tour-shot is-empty" aria-hidden="true"></div>
            {/if}
            <div class="exp-tour-body">
                <span class="exp-tour-no" aria-hidden="true">{$no}</span>
                <span class="exp-tour-where">{$stop_map.teaser_title.content|wash}</span>
                <h2 id="stop-{$no}-title">{$stop.data_map.title.content|wash}</h2>
                <div class="exp-tour-text">{attribute_view_gui attribute=$stop_map.teaser_intro}</div>
            </div>
        </section>
        {if and( $speed, $stop.object.remote_id|eq( 'showcase-s1-stop-04' ) )}
        <section class="exp-tour-speed" id="exp-tour-speed" aria-labelledby="exp-tour-speed-title">
            <h2 id="exp-tour-speed-title">The same pages, Apache and Velocity</h2>
            <p>The same pages of this site, measured on this server through Apache with PHP-FPM and through Exponential Velocity: the median time until the page arrives, once from the cache and once rendered.</p>
            <div class="exp-tour-speed-out" aria-live="polite"><p>Loading the last measurement...</p></div>
            <small>Measured from the server itself on demand of an administrator, never by your visit. Both servers run the same installation, the same database and the same caches.</small>
        </section>
        {/if}
    {/foreach}
    </div>

    <footer class="exp-tour-end">
        <div class="container">
            <h2>That was Exponential 6</h2>
            <p>Everything on this tour is the shipped product on an ordinary server: open source, installed in one command, and documented.</p>
            <div class="exp-tour-actions">
                <a class="exp-tour-btn is-primary" href="https://github.com/se7enxweb/exponential" rel="noopener">Exponential on GitHub</a>
                <a class="exp-tour-btn" href="https://latest.demo.exponential.earth/" rel="noopener">A fresh demo, rebuilt every two hours</a>
                <a class="exp-tour-btn" href="#stop-1">Back to the start</a>
            </div>
        </div>
    </footer>
</div>
<script>
(function () {ldelim}
    // "Open the admin in dark/light mode": the admin keeps its mode in this browser (localStorage exp-admin4-theme)
    document.querySelectorAll('.exp-tour a[href*="/admin/"]').forEach(function (a) {ldelim}
        var m = a.getAttribute('href').match(/#(dark|light)$/);
        if (!m) return;
        a.addEventListener('click', function () {ldelim}
            try {ldelim} localStorage.setItem('exp-admin4-theme', m[1]); {rdelim} catch (e) {ldelim}{rdelim}
        {rdelim});
    {rdelim});
    var out = document.querySelector('.exp-tour-speed-out');
    if (!out || !window.fetch) return;
    function esc(s) {ldelim} return String(s).replace(/[&<>"]/g, function (c) {ldelim} return {ldelim}'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'{rdelim}[c]; {rdelim}); {rdelim}
    function ago(t) {ldelim}
        var s = Math.max(0, Math.round(Date.now() / 1000 - t));
        if (s < 90) return s + ' seconds ago';
        if (s < 5400) return Math.round(s / 60) + ' minutes ago';
        if (s < 129600) return Math.round(s / 3600) + ' hours ago';
        return Math.round(s / 86400) + ' days ago';
    {rdelim}
    function ms(v) {ldelim} return v === null || v === undefined ? '-' : (v < 10 ? v.toFixed(1) : Math.round(v)) + ' ms'; {rdelim}
    fetch({'showcase/speed'|ezurl}, {ldelim} credentials: 'same-origin', cache: 'no-store' {rdelim})
        .then(function (r) {ldelim} return r.json(); {rdelim})
        .then(function (d) {ldelim}
            if (!d.ok || !d.result) {ldelim} out.innerHTML = '<p>No measurement yet. An administrator starts one from the admin dashboard.</p>'; return; {rdelim}
            var r = d.result, html = '';
            function table(rows, title, note) {ldelim}
                var max = 1, h = '';
                rows = rows.filter(function (p) {ldelim} return p.apache.server_ms !== null && p.velocity.server_ms !== null; {rdelim});
                if (!rows.length) return '';
                rows.forEach(function (p) {ldelim} [p.apache.server_ms, p.velocity.server_ms].forEach(function (v) {ldelim} if (v > max) max = v; {rdelim}); {rdelim});
                h += '<h3 class="exp-tour-speed-sub">' + esc(title) + '</h3><p class="exp-tour-speed-note">' + esc(note) + '</p>';
                h += '<table><thead><tr><th>Page</th><th class="num">Apache</th><th class="num">Velocity</th><th class="bar">Median time to answer</th><th class="num">Faster</th></tr></thead><tbody>';
                rows.forEach(function (p) {ldelim}
                    var a = p.apache.server_ms, v = p.velocity.server_ms, f = a / v, win = '';
                    if (f >= 1.1) win = '<span class="exp-tour-factor"><span class="w">Velocity </span>' + f.toFixed(1) + 'x</span>';
                    else if (f <= 0.91) win = '<span class="exp-tour-factor is-a"><span class="w">Apache </span>' + (1 / f).toFixed(1) + 'x</span>';
                    else win = 'even';
                    h += '<tr><td><a data-path="' + esc(p.path) + '">' + esc(p.label) + '</a></td>'
                       + '<td class="num">' + ms(a) + '</td><td class="num">' + ms(v) + '</td>'
                       + '<td class="bar"><span class="exp-tour-bar" data-w="' + Math.max(1, 100 * a / max) + '"></span>'
                       + '<span class="exp-tour-bar is-v" data-w="' + Math.max(1, 100 * v / max) + '"></span></td>'
                       + '<td class="num">' + win + '</td></tr>';
                {rdelim});
                return h + '</tbody></table>';
            {rdelim}
            html += table(r.pages, 'Returning visitors: pages from the cache', 'What most requests are. Velocity answers from its in-memory response cache; Apache from the view cache on disk.');
            if (r.cold && r.cold.length)
                html += table(r.cold, 'Rendered for the request: past every cache', 'A query string no cache has seen, so both servers run Exponential for each request. Here the two are close, and Apache is often a little ahead: honest numbers, not a benchmark trick.');
            html += '<small>Measured ' + esc(ago(r.measured)) + ' (' + esc(new Date(r.measured * 1000).toLocaleString()) + ') with ' + esc(r.method === 'curl' ? 'curl' : './console exp:benchmark')
                 + ', ' + esc(r.rounds) + ' requests per page and server' + (r.cold && r.cold.length ? ' (' + esc(r.cold_rounds) + ' rendered)' : '') + ', two at a time, PHP ' + esc(r.php) + '. Grey: Apache with PHP-FPM; yellow: Velocity.</small>';
            out.innerHTML = html;
            // the page links get their address here, not in the HTML text above: a crawler reading the script
            // as HTML would take the concatenation for an address
            out.querySelectorAll('a[data-path]').forEach(function (a) {ldelim} a.setAttribute('href', a.getAttribute('data-path')); {rdelim});
            // each bar's length is its measurement (exp-page-parts.css has the rest of the bar)
            out.querySelectorAll('.exp-tour-bar[data-w]').forEach(function (b) {ldelim} b.style.width = b.getAttribute('data-w') + '%'; {rdelim});
        {rdelim})
        .catch(function () {ldelim} out.innerHTML = '<p>The measurement could not be loaded right now.</p>'; {rdelim});
{rdelim})();
</script>
{undef $stops $speed $stop_map $img $no}
