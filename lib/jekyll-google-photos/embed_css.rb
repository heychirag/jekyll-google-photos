require "jekyll"
require 'open-uri'
require 'net/http'

class EmbedCSSTag < Liquid::Tag
  def initialize(tagName, text, tokens)
    super
    pswpcss = 'https://raw.githubusercontent.com/dimsemenov/PhotoSwipe/master/dist/photoswipe.css'
    pswpskincss = 'https://raw.githubusercontent.com/dimsemenov/PhotoSwipe/master/dist/default-skin/default-skin.css'
    @csstags = %Q{<style>#{Net::HTTP.get(URI.parse(pswpcss))}</style>}
    @csstags += %Q{<style>#{Net::HTTP.get(URI.parse(pswpskincss))}</style>}
  end

  def render(context)
    "#{@csstags}"
  end

  Liquid::Template.register_tag 'google_photos_css', self
end
