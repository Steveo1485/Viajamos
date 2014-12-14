$ ->

  initFacebook = () ->
    window.fbAsyncInit = ->
      FB.init
        appId: gon.facebook_app_id
        xfbml: true
        version: "v2.1"
    ((d, s, id) ->
      js = undefined
      fjs = d.getElementsByTagName(s)[0]
      return  if d.getElementById(id)
      js = d.createElement(s)
      js.id = id
      js.src = "//connect.facebook.net/en_US/sdk.js"
      fjs.parentNode.insertBefore js, fjs
      return
    ) document, "script", "facebook-jssdk"

  facebookShare = () ->
    $("#fb-share").click (e) ->
        e.preventDefault()
        FB.ui
          method: 'share'
          href: 'http://cotripping.com/'
        , (response) ->

  facebookFeedItem = () ->
    for post in $(".fb-feed-post")
      $post = $(post)
      $post.click (e) ->
        e.preventDefault()
        FB.ui
          method: 'feed'
          link: $(this).data("href"),
          caption: $(this).data("caption")
        , (response) ->

  if gon.facebook_app_id
    initFacebook()

  if $("#fb-share").length > 0
    facebookShare()

  if $(".fb-feed-post").length > 0
    facebookFeedItem()