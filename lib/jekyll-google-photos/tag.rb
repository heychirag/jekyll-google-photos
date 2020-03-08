require "jekyll"
require 'open-uri'
require 'nokogiri'
require 'net/http'
require_relative 'css'

module JekyllGooglePhotos
  class Tag < Liquid::Tag
    def initialize(tagName, args, tokens)
      super
      args = args.split(" ")
      @albumUrls = args[0]
      @maxWidth = args[1]
    end

    def getImageLinks(url)
      doc = Nokogiri::HTML(open(url.strip).read)
      scripts = doc.xpath("//script")
      for x in scripts do
        if x.inner_html.match(/initDataCallback\(/)
          jsonString = x.inner_html
          jsonString = jsonString.sub(/.*function\(\)\{return /,"")
          jsonString["\n}});"] = ""
        end
      end
      json = JSON.parse(jsonString)
      return json[1]
    end

    def flexbinCSS()
      elem = JekyllGooglePhotos::FlexbinCSS()
      return elem
    end

    def URLsInJSON()
      sp = "googlePhotos.urls = ["
      for x in @imgLinks
        sp += "\"#{x}\","
      end
      sp += "];"
      return sp
    end

    def createDOM()
      sp = "<script>"
      sp += "googlePhotos = {};"
      sp += URLsInJSON()
      sp += "</script>"
      if(@maxWidth != "none")
        sp += %Q{<style>}
        sp += flexbinCSS()
        sp += %Q{</style>}
        sp += addImages()
      end
      return sp
    end

    def addImages()
      sp = %Q{<div class="flexbin">}
      idx = 0
      for x in @imgLinks
        link = x + "=w#{@maxWidth}"
        sp += %Q{
                  <div onclick="showSlides(#{idx});" class="slideImgs">
                      <img src="#{link}" />
                  </div>
        }
        idx += 1
      end
      sp += %Q{</div>}
      return sp
    end

    def render(context)
      @imgLinks = []
      if @albumUrls[/https?:\/\/[\S]+/]
        albumUrls = [].push(@albumUrls)
      else
        albumUrls = context[@albumUrls.strip]
        if not albumUrls.instance_of? Array
          albumUrls = [].push(context[@albumUrls.strip])
        end
      end
      for albumUrl in albumUrls
          imageLinks = getImageLinks(albumUrl)
          for link in imageLinks
            @imgLinks.push(link[1][0])
          end
      end
      createDOM()
    end
  end
end

Liquid::Template.register_tag('google_photos', JekyllGooglePhotos::Tag)
