var album = document.getElementsByClassName("google-photos-album")[0];
var albumImages = album.getElementsByTagName("img");
var minPicHeight = 200; var albumMargin ='+@margin.to_s+'; var noPics = 4;
var containerWidth = album.parentElement.clientWidth;
var xcoor = 0; var ycoor = 0;
/*var setHeight = 0;*/'
for(var i=0;i<albumImages.length;i+=noPics) {
  var currMinHeight = 999999999;
  for(var j=i;j<i+noPics&&j<albumImages.length;j++) {
    if(albumImages[j].height<currMinHeight)
      currMinHeight = albumImages[j].height;
  }
  for(var j=i;j<i+noPics&&j<albumImages.length;j++) {
    albumImages[j].width *= currMinHeight/albumImages[j].height;
    albumImages[j].height = currMinHeight;
  }
  var currWidth = (noPics)*albumMargin;
  for(var j=i;j<i+noPics&&j<albumImages.length;j++) {
    currWidth += albumImages[j].width;
  }
  var k; var limitWidth = 0;
  for(var k=i;k<i+noPics-1&&k<albumImages.length;k++) {
    albumImages[k].width *= containerWidth/currWidth;
    limitWidth = limitWidth + albumImages[k].width + albumMargin;
    albumImages[k].height *= containerWidth/currWidth;
  }
  albumImages[k].width = containerWidth-limitWidth;
  albumImages[k].height *= containerWidth/currWidth;
  /*var setWidth = 0;
  for(var j=i;j<i+noPics&&j<albumImages.length;j++) {
    albumImages[j].style.transform = "translate3d($setWidth,$setHeight,0px)";
    setWidth += albumImages[j].width;
    setWidth += albumMargin;
  }
  setHeight += albumImages[i].height;
  setHeight += albumMargin;*/
}
