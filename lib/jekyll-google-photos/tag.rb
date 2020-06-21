require "jekyll"
require 'open-uri'
require 'nokogiri'
require 'net/http'
require_relative 'css'
require_relative 'js'

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

    def flexbinCSS()
      elem = JekyllGooglePhotos::FlexbinCSS()
      return elem
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
      #puts albumSettings
      ##if(albumSettings != "none")
        ##sp += JekyllGooglePhotos::PublicalbumJS()
        ##sp += addImages(albumSettings)
      ##end
      return sp
    end
    
    def imageObject(url)
      sp = %Q{
        <object data="#{url}=w#{@maxWidth}"></object>
      }
      return sp
    end
    
    def addImages(albumSettings)
      sp = %Q{<div class="pa-gallery-player-widget" style="width:#{albumSettings["frame_width"]}; height:#{albumSettings["frame_height"]}; display:none;"
          data-title="#{albumSettings["title"]}"
          data-delay="#{albumSettings["delay"]}">
      }
      for x in @imgLinks
        sp += %Q{<object data="#{x}=w#{albumSettings["image_width"]}-h#{albumSettings["image_height"]}"></object>}
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
          #puts imageLinks[0]
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
