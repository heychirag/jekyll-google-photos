---
layout: post
title:  "Welcome to Jekyll!"
date:   2018-02-22 18:29:32 +0000
categories: jekyll update
gallery_urls:
  - https://photos.app.goo.gl/bhWukds8QVodFU246
  - https://photos.app.goo.gl/bhWukds8QVodFU246
album_settings:
  delay: 5
  title: "Trip to Annecy"
  image_width: 0
  image_height: 0
  frame_height: "200px"
  frame_width: "300px"
---

{% google_photos page.gallery_urls page.album_settings %}

{% google_photos page.gallery_urls page.album_settings %}

You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
