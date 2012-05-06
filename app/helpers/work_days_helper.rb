#encoding: utf-8
module WorkDaysHelper

	def create_calendar(days_array, work_days)
		wdayhash = { 0 => "SO", 1 => "MO", 2 => "DI", 3 => "MI", 4 => "DO", 5 => "FR", 6 => "SA" }
		# TABLE
		content_tag(:table, :border => 0, :textalligne => "center", :class => "caltable"){		
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
							#d = WorkDay.where(day: day.to_date).first
							d = work_days[day.to_date]
							c_c_tag(:td){
								c_c_tag(:div, class: "kalender_zelle round", data_meldung: d.to_json){
									c_c_tag(:small, day.day, class: "kalender_datum badge badge-success")
									
									c_c_tag(:small, ((d.end_work - d.start_work) / 3600).round(2), class: "arbeitszeit")

									c_c_tag(:i, "",class: "icon-info-sign wd_info")
									
									c_c_tag(:div, class: "start_end_zeit"){
										c_c_tag(:small, d.start_work.strftime("%H:%M"), class: "pull-left")	
									#	c_c_tag(:b, "|")
										c_c_tag(:small, d.end_work.strftime("%H:%M"), class: "pull-right")
									}
								} 
								 #c_c_tag(:i, d.end_work.strftime("%H:%M"))
							}

						else
							c_c_tag(:td){
								c_c_tag(:div, class: "kalender_zelle round"){
									c_c_tag(:small, link_to(day.day, new_work_day_path(day: day.to_date)), class: "kalender_datum badge", data_meldung: {"note" => "NOOTTEE"}.to_json)
									c_c_tag(:div, "---", class: "arbeitszeit")
								}
							}
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
