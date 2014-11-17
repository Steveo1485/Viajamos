$ ->
  bindTripTimePeriod = () ->
    $("input[name='trip[certainty]']").parents(".radio").hide()
    $("input[name='trip[time_period]']").change ->
      if $("#trip_time_period_future:checked").length > 0
        displayTripCertaintyRadio()
      else
        $("input[name='trip[certainty]']").parents(".radio").hide()

  displayTripCertaintyRadio = () ->
    $("input[name='trip[certainty]']").parents(".radio").show()


  if $("input[name='trip[time_period]']").length > 0
    bindTripTimePeriod()

  if $("#trip_time_period_future:checked").length > 0
    displayTripCertaintyRadio()