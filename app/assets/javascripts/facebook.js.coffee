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



	if gon.facebook_app_id
		initFacebook()

	if $("#fb-share").length > 0
		facebookShare()