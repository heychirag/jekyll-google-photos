
# Jekyll Google Photos

> 💎 Embed Google Photos Album to your Jekyll Site

[Check out the Demo](http://chira.ga/trip-to-annecy/)

# Installing

Install the gem using:
```
gem install jekyll-google-photos
```

Or use the following if you are using bundler
```
bundle add jekyll-google-photos
```

You also need to add this plugin to your `_config.yml` file:
```
plugins:
  - jekyll-google-photos
```

# Usage:
```
{% google_photos <link_to_album> <max_width> %}
```
`max_width` (pixels): Max width of the image loaded from Google servers for the gallery. Larger widths may increase page load time.

Example:
```
{% google_photos https://photos.app.goo.gl/bhWukds8QVodFU246 800 %}
```
or using variables/front matter

```
{% google_photos post.gallery_url 800 %}
```

#### Note
You can use `0` to get original quality image.

# Want to Display images your way?

Pass `none` into `max_width`. Passing `none` will not display any image. You can now use image urls to display images in any desired way.
```
{% google_photos <link_to_album> none %}
```
The image URLs are present in the following array inside the `googlePhotos` object.
```
googlePhotos.urls = ["img1","img2",...];
```
#### Note
Image urls will always be available at `googlePhotos.urls` irrespective of what is passed in `max_width`.

### Hacking the Image URLs

Google provides us a way to 'hack' the base URL of images to manipulate the quality/dimensions of the images. The following information was taken from Google Photos' official documentation:

<table>
<tr>
<th>
Parameter
</th>
<th>
Description
</th>
</tr>
<tr>
<td>
w, h
</td>
<td>
The width,  <b>w</b>  and height,  <b>h</b>  parameters.

To access an image media item, such as a photo or a thumbnail for a video, you must specify the dimensions that you plan to display in your application (so that the image can be scaled into these dimensions while preserving the aspect ratio). To do this, concatenate the base URL with your required dimensions as shown in the examples.

<b>Example:</b>

<b><i>BASE_URL</i></b>=w<i><b>MAX_WIDTH</b></i>-h<i><b>MAX_HEIGHT</b></i>

Here is an example to display a media item no wider than 2048 px and no taller than 1024 px:

https://lh3.googleusercontent.com/p/AF....VnnY<b>=w2048-h1024</b>
</td>
</tr>
<tr>
<td>
c
</td>
<td>
The crop, <b>c</b> parameter.

If you want to crop the image to the exact width and height dimensions you have specified, concatenate the base URL with the optional -c parameter along with the mandatory w and h parameters.

The size (in pixels) should be in the range [1, 16383]. If either the width or the height of the image, exceeds the requested size, the image is scaled down and cropped (maintaining the aspect ratio).

<b>Example:</b>

<b><i>BASE_URL</i></b>=w<i><b>MAX_WIDTH</b></i>-h<i><b>MAX_HEIGHT</b></i>-c

In this example, the application displays a media item that is exactly 256 px wide by 256 px high, such as a thumbnail:

https://lh3.googleusercontent.com/p/AF....VnnY<b>=w256-h256-c</b>
</td>
</tr>
</table>

#### Note
You can use `=w0-h0` for unaltered image quality.


# Features to implement

* Full-Screen HQ Image View and Slider
* Do something about Videos
