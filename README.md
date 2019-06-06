# Jekyll Google Photos

> 💎 Embedd Google Photos Album to your Jekyll Site

[Check out the Demo](http://chira.ga/trip-to-annecy/)

# Installing

add the following to your Gemfile:
```
gem 'jekyll-google-photos'
gem 'fastimage'
```

then:
```
bundle install
```
Note: Simplified installation is still a WIP

You also need to add this plugin to your `_config.yml` file:
```
plugins:
  - jekyll-google-photos
```

# Usage:
```
{% google_photos <Link to Shared Google Photos Album> %}
```
Example:
```
{% google_photos https://photos.app.goo.gl/bhWukds8QVodFU246 %}
```

# Features to implement

* Revamp Grid Layout Algorithm
* Let users decide how many photos in each row
* Full-Screen HQ Image View and Slider
* Do something about Videos
