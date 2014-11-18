$ ->
  bindTripTimePeriod = () ->
    $("input[name='trip[certainty]']").parents(".radio").hide()
    $("input[name='trip[time_period]']").change ->
      if $("#trip_time_period_future:checked").length > 0
        displayTripCertaintyRadio()
      else
        handleNonFutureTimePeriod()

  displayTripCertaintyRadio = () ->
    $("input[name='trip[certainty]']").parents(".radio").show()

  handleNonFutureTimePeriod = () ->
    $("input[name='trip[certainty]']").removeAttr("checked")
    $("input[name='trip[certainty]']").parents(".radio").hide()


  if $("input[name='trip[time_period]']").length > 0
    bindTripTimePeriod()

  if $("#trip_time_period_future:checked").length > 0
    displayTripCertaintyRadio()