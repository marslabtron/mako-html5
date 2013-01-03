# !/usr/bin/env python
#
# Copyright (c) 2013, Luke Southam <luke@devthe.com>
# All rights reserved.
# http://opensource.org/licenses/BSD-3-Clause

import os
from mako.template import Template

HTML = """<%%namespace name="html">%s</%%namespace>""" % file(os.path.join(os.path.dirname(__file__), 'includes/', 'page.mako')).read()

WRAPPER = """<%%html:five><%%html:head />
    <%%html:body>
        %s
    </%%html:body>
</%%html:five>"""

class Page(object):
    meta = {'title':'', 'description':'', 'keywords':''}
    stylesheets = []
    javascripts = []
    static_paths = {'javascripts':'/js', 'stylesheets':'/css'}
    GA = "UA-XXXXX-X"
    
    def __init__(self, template=None, templatefile=None, title="", wrapper=False):
        self.meta['title'] += title
        self.wrapper = wrapper
        self.template = Template(template, filename=templatefile, preprocessor=self.preprocessor)

    def preprocessor(self, source):
        source = source if self.wrapper else WRAPPER % source
        return HTML + source


    def render(self):
        meta = self.meta
        meta['keywords'] = ','.join(meta['keywords'])
        css = [self.static_paths['stylesheets'] + f for f in self.stylesheets]
        js = [self.static_paths['javascripts'] + f for f in self.javascripts]
        return self.template.render(page=self, meta=meta, css=css, js=js)

    def add_stylesheet(self, link):
        self.stylesheets.append(link)

    def add_javascript(self, link):
        self.javascripts.append(link)