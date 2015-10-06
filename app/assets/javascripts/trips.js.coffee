$ ->

  class Trip
    constructor: ->
      @bindListeners()
      @activateDatePickers()

    bindListeners: ->
      scope = this
      scope.bindAddDestinationLink()
      scope.bindTripStartWithDestinationStart()
      scope.bindTripTimePeriod()

    bindAddDestinationLink: ->
      $('#add-destination').click (e) ->
        e.preventDefault()
        $('.destination.extra:hidden').first().slideDown()
        if $('.destination.extra:visible').length == $('.destination.extra').length
          $('#add-destination').hide()

    bindTripStartWithDestinationStart: ->
      $('#trip_start_date').change ->
        $('#trip_destinations_attributes_0_start_day').val($(this).val())


    bindTripTimePeriod: ->
      scope = this
      $(".certainty").hide()
      $("input[name='trip[time_period]']").change ->
        if $("#trip_time_period_future:checked").length > 0
          scope.displayTripCertaintyRadio()
        else
          scope.handleNonFutureTimePeriod()

    displayTripCertaintyRadio: ->
      $(".certainty").show()

    handleNonFutureTimePeriod: ->
      $("input[name='trip[certainty]']").removeAttr("checked")
      $(".certainty").hide()

    activateDatePickers: ->
      $('input.datepicker').each ->
        altFieldSelector = "#trip_#{$(this).attr('id')}"
        $(this).datepicker
          altField: altFieldSelector
          altFormat: 'dd-mm-yy'


  if $('form.new_trip').length > 0
    new Trip()
