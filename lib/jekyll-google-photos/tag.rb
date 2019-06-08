require "jekyll"
require 'open-uri'
require 'nokogiri'
require 'fastimage'
require 'net/http'

module JekyllGooglePhotos
  class Tag < Liquid::Tag
    def initialize(tagName, url, tokens)
      super
      @small = 400
      @medium = 800
      @large = 1400
      @tolerance = 200
      @imgLinks = getImageLinks(url)
      @dom = createPSWPElem()
      @dom += addScript()
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

    def createPSWPElem()
      elem = %Q{<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
      <!-- Background of PhotoSwipe.
           It's a separate element as animating opacity is faster than rgba(). -->
      <div class="pswp__bg"></div>
      <!-- Slides wrapper with overflow:hidden. -->
      <div class="pswp__scroll-wrap">
          <!-- Container that holds slides.
              PhotoSwipe keeps only 3 of them in the DOM to save memory.
              Don't modify these 3 pswp__item elements, data is added later on. -->
          <div class="pswp__container">
              <div class="pswp__item"></div>
              <div class="pswp__item"></div>
              <div class="pswp__item"></div>
          </div>
          <!-- Default (PhotoSwipeUI_Default) interface on top of sliding area. Can be changed. -->
          <div class="pswp__ui pswp__ui--hidden">
              <div class="pswp__top-bar">
                  <!--  Controls are self-explanatory. Order can be changed. -->
                  <div class="pswp__counter"></div>
                  <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
                  <button class="pswp__button pswp__button--share" title="Share"></button>
                  <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>
                  <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
                  <!-- Preloader demo http://codepen.io/dimsemenov/pen/yyBWoR -->
                  <!-- element will get class pswp__preloader--active when preloader is running -->
                  <div class="pswp__preloader">
                      <div class="pswp__preloader__icn">
                        <div class="pswp__preloader__cut">
                          <div class="pswp__preloader__donut"></div>
                        </div>
                      </div>
                  </div>
              </div>
              <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                  <div class="pswp__share-tooltip"></div>
              </div>
              <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
              </button>
              <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
              </button>
              <div class="pswp__caption">
                  <div class="pswp__caption__center"></div>
              </div>
          </div>
      </div>
  </div>}
      return elem
    end

    def addScript()
      sp = %Q{<script>}
      sp += %Q{var pswpElement = document.querySelectorAll('.pswp')[0];}
      sp += addImages()
      sp += addOptions()
      sp += %Q{var GPGallery = new PhotoSwipe(pswpElement,
                                              PhotoSwipeUI_Default,
                                              GPImages, GPOptions);}
      sp += responsiveImages()
      sp += %Q{GPGallery.init()}
      sp += %Q{</script>}
      return sp
    end

    def addOptions()
      sp = %Q{var GPOptions = [}
      sp += %Q{];}
      return sp
    end

    def addImages()
      sp = %Q{var GPImages = [}
      for x in @imgLinks
        smallLink = x[1][0] + %Q{=w#{@small}}
        smallDims = FastImage.size(smallLink);
        medLink = x[1][0] + %Q{=w#{@medium}}
        medDims = FastImage.size(medLink)
        larLink = x[1][0] + %Q{=w#{@large}}
        larDims = FastImage.size(larLink)
        puts smallLink
        puts medLink
        puts larLink
        sp += %Q{\{
                    small: \{
                      src: '#{smallLink}',
                      w: #{smallDims[0]},
                      h: #{smallDims[1]}
                    \},
                    medium: \{
                      src: '#{medLink}',
                      w: #{medDims[0]},
                      h: #{medDims[1]}
                    \},
                    large: \{
                      src: '#{larLink}',
                      w: #{larDims[0]},
                      h: #{larDims[1]}
                    \}
                  \},}
      end
      sp += %Q{];}
      return sp
    end

    def responsiveImages()
      sp = %Q{
      var realViewportWidth,
      useLarge = false,
      useMedium = false,
      firstResize = true,
      imageSrcWillChange;
      GPGallery.listen('beforeResize', function() \{
        realViewportWidth = GPGallery.viewportSize.x * window.devicePixelRatio;
        if(useLarge && !useMedium &&realViewportWidth >= #{@small+@tolerance}) \{
          useLarge = false;
          useMedium = true;
          imageSrcWillChange = true;
        \}
        else if(!useLarge && useMedium && realViewportWidth >= #{@medium+@tolerance}) \{
          useLarge = true;
          useMedium = false;
          imageSrcWillChange = true;
        \}
        else \{
          useMedium = false;
          useLarge = false;
          imageSrcWillChange = true;
        \}

      if(imageSrcWillChange && !firstResize) \{
        gallery.invalidateCurrItems();
      \}

      if(firstResize) \{
        firstResize = false;
      \}

      imageSrcWillChange = false;

      \});

      GPGallery.listen('gettingData', function(index, item) \{
        if(useLarge) \{
          item.src = item.large.src;
          item.w = item.large.w;
          item.h = item.large.h;
        \}
        else if (useMedium) \{
          item.src = item.medium.src;
          item.w = item.medium.w;
          item.h = item.medium.h;
        \}
        else \{
          item.src = item.small.src;
          item.w = item.small.w;
          item.h = item.small.h;
        \}
      \});
      }
      return sp
    end

    def render(context)
      "#{@dom}"
    end
  end
end

Liquid::Template.register_tag('google_photos', JekyllGooglePhotos::Tag)
