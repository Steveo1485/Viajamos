class TripDecorator < Draper::Decorator
  delegate_all

  def panel_title
    h.raw("#{h.fa_icon('map-marker')} #{model.time_period.capitalize} Trip")
  end

  def panel_date_range
    h.raw("#{h.fa_icon('calendar')} #{model.start_date.strftime("%e %b, %Y")} – #{model.end_date.strftime("%e %b, %Y")}")
  end

  def panel_destinations
    "#{h.pluralize(trip.cities.count, 'Destination')}: #{model.cities.join(', ')}"
  end

  def panel_comments
    if model.comments.present?
      quote_icon = h.content_tag(:span, h.fa_icon('quote-left'), class: 'quote')
      h.content_tag(:p, h.raw(quote_icon + model.comments))
    else
      nil
    end
  end

end
