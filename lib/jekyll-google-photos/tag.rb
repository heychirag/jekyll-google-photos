require "jekyll"
require 'open-uri'
require 'nokogiri'
require 'net/http'

module JekyllGooglePhotos
  class Tag < Liquid::Tag
    def initialize(tagName, args, tokens)
      super
      args = args.split(" ")
      @albumUrls = args[0]
      @albumSettings = args[1]
    end

    def getImageLinks(url)
      doc = Nokogiri::HTML(open(url.strip).read)
      scripts = doc.xpath("//script")
      jsonString = ""
      for x in scripts do
        if x.inner_html.match(/initDataCallback\(/)
          jsonString = x.inner_html
          jsonString = jsonString.scan(/\[\"(http.*googleusercontent.com\/[^((?!\/a\/).)*$].*)\"/)
        end
      end
      return jsonString
    end

    def URLsInJSON()
      sp = 'googlePhotos.urls = ["'
      newImgLinks = @imgLinks.uniq.join('", "')
      sp += "#{newImgLinks}"
      sp += '"];'
      return sp
    end

    def createDOM(albumSettings)
      sp = "<script>"
      sp += "googlePhotos = {};"
      sp += URLsInJSON()
      sp += "</script>"
      return sp
    end
    
    def imageObject(url)
      sp = %Q{
        <object data="#{url}=w#{@maxWidth}"></object>
      }
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
            @imgLinks.push(link)
          end
      end 
      if @albumSettings != "none"
        albumSettings = context[@albumSettings.strip]
      end
      createDOM(albumSettings)
    end
  end
end

Liquid::Template.register_tag('google_photos', JekyllGooglePhotos::Tag)
