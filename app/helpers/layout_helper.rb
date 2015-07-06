module LayoutHelper

  def body_classes
    [params[:controller], params[:action]].join('-')
  end

	def copyright
		raw("&copy; Co:tripping 2014 - #{Date.today.year}")
	end
end