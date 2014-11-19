module PlannerHelper

  def upcoming_trips_tab
    badge = content_tag(:span, current_user.trips.upcoming.count, class: "badge")
    link_to(raw("Upcoming #{badge}"), "#upcoming", role: "tab", "data-toggle" => "tab")
  end

  def past_trips_tab
    badge = content_tag(:span, current_user.trips.past.count, class: "badge")
    link_to(raw("Past Trips #{badge}"), "#past-trips", role: "tab", "data-toggle" => "tab")
  end

  def wishlist_trips_tab
    badge = content_tag(:span, current_user.trips.wishlist.count, class: "badge")
    link_to(raw("Wishlist #{badge}"), "#wishlist", role: "tab", "data-toggle" => "tab")
  end
end