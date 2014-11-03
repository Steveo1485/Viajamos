$(document).on('ready page:load', ->

  loadGoogleMap = () ->
    mapOptions =
      center:
        lat: 39.739691
        lng: 0
      zoom: 3

    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

  if $("#map-canvas").length > 0
    loadGoogleMap()
)