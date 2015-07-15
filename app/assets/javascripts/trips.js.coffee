$ ->

  class Trip
    constructor: ->
      @bindAddDestinationLink()
      @initDatepicker()

    bindAddDestinationLink: ->
      $("#add-destination").click (e) ->
        e.preventDefault()
        $(".destination.extra:hidden").first().slideDown()
        if $(".destination.extra:visible").length == $(".destination.extra").length
          $("#add-destination").hide()

    initDatepicker: ->
      $('input.datepicker').each ->
        $(this).datepicker()


  if $('form.new_trip').length > 0
    new Trip()