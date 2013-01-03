##
## Copyright (c) 2013, Luke Southam <luke@devthe.com>
## All rights reserved.
## http://opensource.org/licenses/BSD-3-Clause
<%doc>
    Some simple mako functions to create a html5 webpage in
    accordance to html5boilerplate:
        https://github.com/h5bp/html5-boilerplate
    USAGE:
        <%namespace name="html" file="includes/page.mako" />
        <%html:five>
            <%html:head>
                <!-- Head -->
            </%html:head>
            <%html:body>
                <h1>Hello World !</h1>
            </%html:body>
        </%html:five>
</%doc>
<%def name="five()">
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    ${caller.body()}
</html>
</%def>
<%def name="head()">
<head>
    ${metas()}
    ${stylesheets()}
    <script src="${page.static_paths['javascripts']}/vendor/modernizr-2.6.2.min.js"></script>
    ${caller.body()}
</head>
</%def>

<%def name="body()">
<body>
    <%call expr="ifie(7, 'lt')">
        <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
    </%call>

${caller.body()}

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="${page.static_paths['javascripts']}/vendor/jquery-1.8.3.min.js"><\/script>')</script>
    ${javascripts()}
    <script>
        var _gaq=[['_setAccount','${page.GA}'],['_trackPageview']];
        (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
        g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
        s.parentNode.insertBefore(g,s)}(document,'script'));
    </script>
</body>
</%def>

<%def name="stylesheet(href)"><link rel="stylesheet" href="${page.static_paths['stylesheets']}${href}"></%def>
<%def name="stylesheets()">
    ${stylesheet("/vendor/normalize.css")}
% for link in css:
    ${stylesheet(link)}
% endfor
</%def>

<%def name="javascripts()">
% for link in js:
    <script src="${page.static_paths['javascripts']}${link}"></script>
% endfor
</%def>

<%def name="metas()">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>${meta['title']}</title>
    <meta name="description" content="${meta['description']}">
    <meta name="keywords" content="${meta['keywords']}">
    <meta name="viewport" content="width=device-width">
</%def>

<%def name="ifie(version, condition='')"><!--[if ${condition} IE ${version}]>
    ${caller.body()}
    <![endif]--></%def>