require "jekyll"
require 'open-uri'
require 'nokogiri'
require 'net/http'

module JekyllGooglePhotos
  class Tag < Liquid::Tag
    def initialize(tagName, args, tokens)
      super
      args = args.split(" ")
      url = args[0]
      @maxWidth = args[1]
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
                    margin: -2.5px;
                  }
                  .flexbin:after {
                    content: "";
                    flex-grow: 999999999;
                    min-width: 300px;
                    height: 0;
                  }
                  .flexbin > * {
                    position: relative;
                    display: block;
                    height: 300px;
                    margin: 2.5px;
                    flex-grow: 1;
                  }
                  .flexbin > * > img {
                    height: 300px;
                    object-fit: cover;
                    max-width: 100%;
                    min-width: 100%;
                    vertical-align: bottom;
                  }
                  .flexbin.flexbin-margin {
                    margin: 2.5px;
                  }
                  @media (max-width: 300px) {
                    .flexbin {
                      display: flex;
                      overflow: hidden;
                      flex-wrap: wrap;
                      margin: -2.5px;
                    }
                    .flexbin:after {
                      content: "";
                      flex-grow: 999999999;
                      min-width: 75px;
                      height: 0;
                    }
                    .flexbin > * {
                      position: relative;
                      display: block;
                      height: 75px;
                      margin: 2.5px;
                      flex-grow: 1;
                    }
                    .flexbin > * > img {
                      height: 75px;
                      object-fit: cover;
                      max-width: 100%;
                      min-width: 100%;
                      vertical-align: bottom;
                    }
                    .flexbin.flexbin-margin {
                      margin: 2.5px;
                    }
                  }
                  @media (min-width: 300px) and (max-width: 450px) {
                    .flexbin {
                      display: flex;
                      overflow: hidden;
                      flex-wrap: wrap;
                      margin: -2.5px;
                    }
                    .flexbin:after {
                      content: "";
                      flex-grow: 999999999;
                      min-width: 112px;
                      height: 0;
                    }
                    .flexbin > * {
                      position: relative;
                      display: block;
                      height: 112px;
                      margin: 2.5px;
                      flex-grow: 1;
                    }
                    .flexbin > * > img {
                      height: 112px;
                      object-fit: cover;
                      max-width: 100%;
                      min-width: 100%;
                      vertical-align: bottom;
                    }
                    .flexbin.flexbin-margin {
                      margin: 2.5px;
                    }
                  }
                  @media (min-width: 450px) and (max-width: 600px) {
                    .flexbin {
                      display: flex;
                      overflow: hidden;
                      flex-wrap: wrap;
                      margin: -2.5px;
                    }
                    .flexbin:after {
                      content: "";
                      flex-grow: 999999999;
                      min-width: 150px;
                      height: 0;
                    }
                    .flexbin > * {
                      position: relative;
                      display: block;
                      height: 150px;
                      margin: 2.5px;
                      flex-grow: 1;
                    }
                    .flexbin > * > img {
                      height: 150px;
                      object-fit: cover;
                      max-width: 100%;
                      min-width: 100%;
                      vertical-align: bottom;
                    }
                    .flexbin.flexbin-margin {
                      margin: 2.5px;
                    }
                  }
                  @media (min-width: 600px) and (max-width: 750px) {
                    .flexbin {
                      display: flex;
                      overflow: hidden;
                      flex-wrap: wrap;
                      margin: -2.5px;
                    }
                    .flexbin:after {
                      content: "";
                      flex-grow: 999999999;
                      min-width: 175px;
                      height: 0;
                    }
                    .flexbin > * {
                      position: relative;
                      display: block;
                      height: 175px;
                      margin: 2.5px;
                      flex-grow: 1;
                    }
                    .flexbin > * > img {
                      height: 175px;
                      object-fit: cover;
                      max-width: 100%;
                      min-width: 100%;
                      vertical-align: bottom;
                    }
                    .flexbin.flexbin-margin {
                      margin: 2.5px;
                    }
                  }
                  @media (min-width: 750px) and (max-width: 900px) {
                    .flexbin {
                      display: flex;
                      overflow: hidden;
                      flex-wrap: wrap;
                      margin: -2.5px;
                    }
                    .flexbin:after {
                      content: "";
                      flex-grow: 999999999;
                      min-width: 175px;
                      height: 0;
                    }
                    .flexbin > * {
                      position: relative;
                      display: block;
                      height: 175px;
                      margin: 2.5px;
                      flex-grow: 1;
                    }
                    .flexbin > * > img {
                      height: 175px;
                      object-fit: cover;
                      max-width: 100%;
                      min-width: 100%;
                      vertical-align: bottom;
                    }
                    .flexbin.flexbin-margin {
                      margin: 2.5px;
                    }
                  }
                  @media (min-width: 900px) and (max-width: 1050px) {
                    .flexbin {
                      display: flex;
                      overflow: hidden;
                      flex-wrap: wrap;
                      margin: -2.5px;
                    }
                    .flexbin:after {
                      content: "";
                      flex-grow: 999999999;
                      min-width: 175px;
                      height: 0;
                    }
                    .flexbin > * {
                      position: relative;
                      display: block;
                      height: 175px;
                      margin: 2.5px;
                      flex-grow: 1;
                    }
                    .flexbin > * > img {
                      height: 175px;
                      object-fit: cover;
                      max-width: 100%;
                      min-width: 100%;
                      vertical-align: bottom;
                    }
                    .flexbin.flexbin-margin {
                      margin: 2.5px;
                    }
                  }
                  @media (min-width: 1050px) {
                    .flexbin {
                      display: flex;
                      overflow: hidden;
                      flex-wrap: wrap;
                      margin: -2.5px;
                    }
                    .flexbin:after {
                      content: "";
                      flex-grow: 999999999;
                      min-width: 180px;
                      height: 0;
                    }
                    .flexbin > * {
                      position: relative;
                      display: block;
                      height: 180px;
                      margin: 2.5px;
                      flex-grow: 1;
                    }
                    .flexbin > * > img {
                      height: 180px;
                      object-fit: cover;
                      max-width: 100%;
                      min-width: 100%;
                      vertical-align: bottom;
                    }
                    .flexbin.flexbin-margin {
                      margin: 2.5px;
                    }
                  }
                  .stage{
                      position:absolute;
                      width:100%;
                      height:100%;
                      background-color: black;
                      top:0;
                      left:0;
                    }
                    .stage img {
                        position:absolute;
                        left:0; right:0;
                        top:0; bottom:0;
                        margin:auto;
                        max-width:100%;
                        max-height:100%;
                        overflow:auto;
                    }
                  }
      return elem
    end

    def URLsInJSON()
      sp = "googlePhotos.urls = ["
      for x in @imgLinks
        sp += "\"#{x[1][0]}\","
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
        link = x[1][0] + "=w#{@maxWidth}"
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
      @dom
    end
  end
end

Liquid::Template.register_tag('google_photos', JekyllGooglePhotos::Tag)
