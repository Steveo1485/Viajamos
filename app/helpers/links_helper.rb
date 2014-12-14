module LinksHelper
  def facebook_feed_button(url=request.original_url, caption="Co:tripping - Travel is more fun with friends.")
    content_tag(:div, "REPLACE ME!", class: "fb-feed-post", "data-href" => url, "data-caption" => caption)
  end
end