$ ->
  bindAddDestinationLink = () ->
    $("#add-destination").click (e) ->
      e.preventDefault()
      $(".destination.extra:hidden").first().slideDown()
      if $(".destination.extra:visible").length == $(".destination.extra").length
        $("#add-destination").hide()

  loadDayOffsetOptions = ->
    $(".trip-date").change ->
      difference = (endDate() - startDate()) / 1000 / 60 / 60 / 24
      console.log(difference)
      if difference > 0
        $(".day-offset").empty()
        for n in [0..difference]
          option = $("<option></option>").attr("value", n).text(n)
          $(".day-offset").append(option)

  startDate = ->
    day = $("#trip_start_date_3i").val()
    month = $("#trip_start_date_2i").val()
    year = $("#trip_start_date_1i").val()
    if day && month && year
      return new Date(year, (month - 1), day)
    else
      return new Date()

  endDate = ->
    day = $("#trip_end_date_3i").val()
    month = parseInt($("#trip_end_date_2i").val())
    year = $("#trip_end_date_1i").val()
    if day && month && year
      return new Date(year, (month - 1), day)
    else
      today = new Date()
      return new Date(today.setDate(today.getDate() + 10))

  if $("#add-destination").length > 0
    bindAddDestinationLink()

  if $(".trip-date").length > 0
    loadDayOffsetOptions()