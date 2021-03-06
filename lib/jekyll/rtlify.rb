# -*- coding: utf-8 -*-

module Jekyll
  class RTLifyTag < Liquid::Tag

    def initialize(tag_name, variable, tokens)
      super
      if match = variable.match(/{{\s*(.*)\s*}}/)
        @variable, = match.captures
      else
        raise 'invalid variable'
      end
    end

    def render(context)
      html = context.find_variable(@variable)
      tags = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'ul', 'ol']
      tags.each { |tag| html = html.gsub(/<#{tag}\s/, "<#{tag} dir=\"auto\" ")}
      tags.each { |tag| html = html.gsub(/<#{tag}>/, "<#{tag} dir=\"auto\">")}
      html
    end

  end
end

Liquid::Template.register_tag('rtlify', Jekyll::RTLifyTag)
