#encoding: utf-8
module WorkDaysHelper

	def create_calendar(days_array, work_days)
		wdayhash = { 0 => "SO", 1 => "MO", 2 => "DI", 3 => "MI", 4 => "DO", 5 => "FR", 6 => "SA" }
		# TABLE
		content_tag(:table, :border => 1, :textalligne => "center", :class => "caltable"){		
			# Table header
			c_c_tag(:tr){
				wdayhash.each do |i, j| 
					c_c_tag(:th, j) if i != 0
				end
				c_c_tag(:th, wdayhash[0])
			}
			# Table content
			days_array.each do |week_hash|
				c_c_tag(:tr){
					week_hash.each do |wday, day|
						if work_days[day.to_date].class == WorkDay 
							d = WorkDay.where(day: day.to_date).first
							c_c_tag(:td, class: "atag"){
								 c_c_tag(:i, d.start_work.strftime("%H:%M"))
							}
						else
							concat content_tag(:td, day.day, class: "atag")
						end
					end
				}
			end
		} 
	end


	def infobox(title, &block)
  	content_tag(:div, :class => 'infobox') do
    	content_tag(:h3, title) +
    	image_tag('trenner.png') +
    	content_tag(:div, :class => 'infobox_content') do
      	with_output_buffer(&block)
    	end
  	end
	end

end
