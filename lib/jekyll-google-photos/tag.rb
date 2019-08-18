require "jekyll"
require 'open-uri'
require 'nokogiri'
require 'fastimage'
require 'net/http'

module JekyllGooglePhotos
  class Tag < Liquid::Tag
    def initialize(tagName, args, tokens)
      super
      args = args.split(" ")
      url = args[0]
      @row_height = args[1].to_i
      @space = args[6].to_i
      @tablet_max = args[4].to_i
      @row_height_tablet = args[2].to_i
      @space_tablet = @space
      @phone_max = args[5].to_i
      @row_height_phone = args[3].to_i
      @space_phone = @space
      @imgLinks = getImageLinks(url)
      @dom = createDOM()
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
      elem = %Q{
                  .flexbin {
                       display: flex;
                       overflow: hidden;
                       flex-wrap: wrap;
                       margin: -#{@space/2.0}px;
                  }
                   .flexbin:after {
                       content: '';
                       flex-grow: 999999999;
                       min-width: #{@row_height}px;
                       height: 0;
                  }
                   .flexbin > * {
                       position: relative;
                       display: block;
                       height: #{@row_height}px;
                       margin: #{@space/2.0}px;
                       flex-grow: 1;
                  }
                   .flexbin > * > img {
                       height: #{@row_height}px;
                       object-fit: cover;
                       max-width: 100%;
                       min-width: 100%;
                       vertical-align: bottom;
                  }
                   .flexbin.flexbin-margin {
                       margin: #{@space/2.0}px;
                  }
                   @media (max-width: #{@tablet_max}px) {
                       .flexbin {
                           display: flex;
                           overflow: hidden;
                           flex-wrap: wrap;
                           margin: -#{@space/2.0}px;
                      }
                       .flexbin:after {
                           content: '';
                           flex-grow: 999999999;
                           min-width: #{@row_height_tablet}px;
                           height: 0;
                      }
                       .flexbin > * {
                           position: relative;
                           display: block;
                           height: #{@row_height_tablet}px;
                           margin: #{@space/2.0}px;
                           flex-grow: 1;
                      }
                       .flexbin > * > img {
                           height: #{@row_height_tablet}px;
                           object-fit: cover;
                           max-width: 100%;
                           min-width: 100%;
                           vertical-align: bottom;
                      }
                       .flexbin.flexbin-margin {
                           margin: #{@space/2.0}px;
                      }
                  }
                   @media (max-width: #{@phone_max}px) {
                       .flexbin {
                           display: flex;
                           overflow: hidden;
                           flex-wrap: wrap;
                           margin: -#{@space/2.0}px;
                      }
                       .flexbin:after {
                           content: '';
                           flex-grow: 999999999;
                           min-width: #{@row_height_phone}px;
                           height: 0;
                      }
                       .flexbin > * {
                           position: relative;
                           display: block;
                           height: #{@row_height_phone}px;
                           margin: #{@space/2.0}px;
                           flex-grow: 1;
                      }
                       .flexbin > * > img {
                           height: #{@row_height_phone}px;
                           object-fit: cover;
                           max-width: 100%;
                           min-width: 100%;
                           vertical-align: bottom;
                      }
                       .flexbin.flexbin-margin {
                           margin: #{@space/2.0}px;
                      }
                  }

      }
      return elem
    end

    def createDOM()
      sp = %Q{<style>}
      sp += flexbinCSS()
      sp += %Q{</style>}
      sp += addImages()
      return sp
    end

    def addImages()
      sp = %Q{<div class="flexbin">}
      for x in @imgLinks
        link = x[1][0] + %Q{=w#{@tablet_max}}
        sp += %Q{
                  <a href="#{x[1][0]}">
                      <img src="#{link}" />
                  </a>
        }
      end
      sp += %Q{</div>}
      return sp
    end

    def render(context)
      @dom
    end
  end
end

Liquid::Template.register_tag('google_photos', JekyllGooglePhotos::Tag)
