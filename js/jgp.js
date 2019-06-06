var jgp = {};
var album = document.getElementsByClassName("google-photos-album")[0];
var albumImages = album.getElementsByTagName("img");
var minPicHeight = 150;
var albumMargin = 7;
var noPics = 4;
var containerWidth = album.parentElement.clientWidth;
/*var setHeight = 0;*/

var tryPlace = function(start, end) {
  var currMaxHeight = 0;
  for(var j=start;j<=end;j++) {
    if(albumImages[j].height>currMaxHeight)
      currMaxHeight = albumImages[j].height;
  }
  for(var j=start;j<=end;j++) {
    console.log(albumImages[j].width);
    albumImages[j].width *= currMaxHeight;
    console.log(albumImages[j].width);
    albumImages[j].width /= albumImages[j].height;
    console.log(albumImages[j].width);
    console.log(albumImages[j].height);
    albumImages[j].height = currMaxHeight;
    console.log(albumImages[j].height);
  }
  var currWidth = (start-end)*albumMargin;
  for(var j=start;j<=end;j++) {
    currWidth += albumImages[j].width;
  }
  //var k; var limitWidth = 0;
  for(var k=start;k<=end;k++) {
    albumImages[k].width *= containerWidth;
    albumImages[k].width /= currWidth;
    //limitWidth = limitWidth + albumImages[k].width + albumMargin;
    albumImages[k].height *= containerWidth;
    albumImages[k].height /= currWidth;
  }
  //albumImages[k].width = containerWidth-limitWidth;
  //albumImages[k].height *= containerWidth/currWidth;
  console.log(albumImages[start].height);
  return albumImages[start].height;
}

var startPlace = function() {
  var start = 0;
  while(start!=albumImages.length) {
    end = start+noPics;
    end = Math.min(end,albumImages.length-1);
    while(tryPlace(start,end)<minPicHeight&&start!=end) {
      end--;
    }
    start = end+1;
  }
}

startPlace();
