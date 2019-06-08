require "jekyll"
require 'open-uri'
require 'net/http'

class EmbedJSTag < Liquid::Tag
  def initialize(tagName, text, tokens)
    super
    pswpjs = 'https://raw.githubusercontent.com/dimsemenov/PhotoSwipe/master/dist/photoswipe.min.js'
    pswpuijs = 'https://raw.githubusercontent.com/dimsemenov/PhotoSwipe/master/dist/photoswipe-ui-default.min.js'
    @jstags = %Q{<script>#{Net::HTTP.get(URI.parse(pswpjs))}</script>}
    @jstags += %Q{<script>#{Net::HTTP.get(URI.parse(pswpuijs))}</script>}
  end

  def render(context)
    "#{@jstags}"
  end

  Liquid::Template.register_tag 'google_photos_js', self
end
