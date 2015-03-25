module LayoutHelper
	def copyright
		raw("&copy; Co:tripping 2014 - #{Date.today.year}")
	end
end