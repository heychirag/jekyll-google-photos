# Jekyll Google Photos

> 💎 Embedd Google Photos Album to your Jekyll Site

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
`max_width`: Max width of the image loaded from Google servers for the gallery. Larger widths may increase page load time.

Example:
```
{% google_photos https://photos.app.goo.gl/bhWukds8QVodFU246 800 %}
```

# Features to implement

* Full-Screen HQ Image View and Slider
* Do something about Videos
