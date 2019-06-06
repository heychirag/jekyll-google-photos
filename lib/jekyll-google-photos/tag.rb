require "jekyll"
require 'open-uri'
require 'nokogiri'
require 'fastimage'

# https://jekyllrb.com/docs/plugins/#tags

module JekyllGooglePhotos
  class Tag < Liquid::Tag
    def initialize(tagName, url, tokens)
      super
      @url = url

      @doc = Nokogiri::HTML(open(@url.strip).read)

      @scripts = @doc.xpath("//script")

      for $x in @scripts do
        if $x.inner_html.match(/initDataCallback\(/)
          @jsonString = $x.inner_html
          @jsonString = @jsonString.sub(/.*function\(\)\{return /,"")
          @jsonString["\n}});"] = ""
        end
      end

      @json = JSON.parse(@jsonString)
      @imgChildren = @json[1]
      $i = 0
      @margin = 7;
      @imgDOMS = %Q{<div class="google-photos-album" style="position:relative;margin-left:-#{@margin}px;margin-top:-#{@margin}px;">}
      for $x in @imgChildren do
        @dims = FastImage.size($x[1][0]);
        @imgDOMS += (%Q{<img src="#{$x[1][0]}" width="#{@dims[0]}" height="#{@dims[1]}" style="margin-left:#{@margin}px;margin-top:#{@margin}px;" />})
        puts $i
        $i += 1
      end
      @imgDOMS += %Q{</div>}

      @imgDOMS += %Q{<script>#{insertScript()}</script>}
    end

    def insertScript
      result = 'var album = document.getElementsByClassName("google-photos-album")[0];'
      result += 'var albumImages = album.getElementsByTagName("img");'
      result += 'var minPicHeight = 200; var albumMargin ='+@margin.to_s+'; var noPics = 4;'
      result += 'var containerWidth = album.parentElement.clientWidth;'
      result += 'var xcoor = 0; var ycoor = 0;'
      result += '/*var setHeight = 0;*/'
      result += 'for(var i=0;i<albumImages.length;i+=noPics) {'
      result += 'var currMinHeight = 999999999;'
      result += 'for(var j=i;j<i+noPics&&j<albumImages.length;j++) {'
      result += 'if(albumImages[j].height<currMinHeight)'
      result += 'currMinHeight = albumImages[j].height;'
      result += '}'
      result += 'for(var j=i;j<i+noPics&&j<albumImages.length;j++) {'
      result += 'albumImages[j].width *= currMinHeight/albumImages[j].height;'
      result += 'albumImages[j].height = currMinHeight;'
      result += '}'
      result += 'var currWidth = (noPics)*albumMargin;'
      result += 'for(var j=i;j<i+noPics&&j<albumImages.length;j++) {'
      result += 'currWidth += albumImages[j].width;'
      result += '}'
      result += 'var k; var limitWidth = 0;'
      result += 'for(var k=i;k<i+noPics-1&&k<albumImages.length;k++) {'
      result += 'albumImages[k].width *= containerWidth/currWidth;'
      result += 'limitWidth = limitWidth + albumImages[k].width + albumMargin;'
      result += 'albumImages[k].height *= containerWidth/currWidth;'
      result += '}'
      result += 'albumImages[k].width = containerWidth-limitWidth;'
      result += 'albumImages[k].height *= containerWidth/currWidth;'
      result += '/*var setWidth = 0;'
      result += 'for(var j=i;j<i+noPics&&j<albumImages.length;j++) {'
      result += 'albumImages[j].style.transform = "translate3d($setWidth,$setHeight,0px)";'
      result += 'setWidth += albumImages[j].width;'
      result += 'setWidth += albumMargin;'
      result += '}'
      result += 'setHeight += albumImages[i].height;'
      result += 'setHeight += albumMargin;*/'
      result += '}'
    end

    def render(context)
      "#{@imgDOMS}"
    end
  end
end

Liquid::Template.register_tag('google_photos', JekyllGooglePhotos::Tag)
