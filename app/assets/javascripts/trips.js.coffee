$ ->
  bindAddDestinationLink = () ->
    $("#add-destination").click (e) ->
      e.preventDefault()
      $(".destination.extra:hidden").first().slideDown()
      if $(".destination.extra:visible").length >= 2
        $("#add-destination").hide()


  if $("#add-destination").length > 0
    bindAddDestinationLink()