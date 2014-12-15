module LinksHelper
  def facebook_feed_button(text, url=request.original_url, caption="Co:tripping - Travel is more fun with friends.")
    content_tag(:div, raw("#{fa_icon('facebook')} #{text}"), class: "fb-feed-post", "data-href" => url, "data-caption" => caption)
  end
end