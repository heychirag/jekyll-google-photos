# Jekyll Google Photos

> 💎 Embedd Google Photos Album to your Jekyll Site

[Check out the Demo](http://chira.ga/trip-to-annecy/)

# Installing

add the following to your plugins in `_config.yml`:
```
- jekyll-google-photos
```

Install the gem using bundle or use the regular gem installation method
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
{% google_photos <link_to_album> row_height row_height_tablet row_height_phone tablet_max phone_max margin %}
```
`row_height`: Row height on the biggest screen (in pixels)
`row_height_tablet`: Row height on tablets (in pixels)
`row_height_phone`: Row height on phones (in pixels)
`tablet_max`: Width below which `row_height_tablet` will be used (in pixels)
`phone_max`: Width below which `row_height_phone` will be used (in pixels)
`margin`: space or margin between rows and adjacent photos

Example:
```
{% google_photos https://photos.app.goo.gl/bhWukds8QVodFU246 300 150 100 1280 400 5 %}
```

# Features to implement

* Full-Screen HQ Image View and Slider
* Do something about Videos
