module MyCalendar

  # Erzeugt aus übergebenen WorkDay Array ein Hash mit den Monatstagen (1-31) als Schlüssel
  # und dem WorkDay Objekt als Wert.
  # Parameter: [WorkDay]
  def create_calendar_month_hash work_days
    work_days_hash = Hash.new("XXX")
    work_days.each do |i| 
      puts i.day.day
      work_days_hash[i.day.day] = i
    end
    work_days_hash
  end

  # Erzeugt für den übergebenen Monat ein Array Wochen.
  # Jede Woch in dem Array ist ein Hash mit dem Wochentag als Schlüssel und dem Monatstag als Wert. 
  # Parameter: Time Objekt 
  def wdays_array_for_month(time)
    days = Array.new
    week = Hash.new
    last_week_day = Integer

    new_time = time.beginning_of_month
    week_begin = new_time.wday
    week_end = time.end_of_month.wday

    puts "###### #{week_begin}"

    if week_begin != 1
      [1, 2, 3, 4, 5, 6, 0].each do |i| 
        puts "------------------- #{i}"
        if i == week_begin 
          break
        end
        week[i] = "XXX" 
      end  
    end

    (time.end_of_month.day).times do |j|
      if new_time.wday == 0
        week[0] = new_time.day
        days << week
        week = Hash.new
        new_time += 1.day
        next
      end

      week[new_time.wday] = new_time.day
      last_week_day = new_time.wday
      new_time += 1.day
    end

    if last_week_day != 0
      [1, 2, 3, 4, 5, 6].each do |i|
        next if last_week_day >= i
        week[i] = "XXX" 
      end  
      week[0] = "XXX"
      days << week
    end
  end

  # Die Helper Methode um den Kalender im Browser darzustellen
  def create_calendar(days_array, work_days)
    init = true
    wdayhash = { 0 => "SO", 1 => "MO", 2 => "DI", 3 => "MI", 4 => "DO", 5 => "FR", 6 => "SA" }
    #(days_hash[1].to_i - 1) < 0 ? first_week_day = 6 : first_week_day = (days_hash[1].to_i - 1)
    # TABLE
    content_tag(:table, :border => 1, :width => "90%", :textalligne => "center"){ 
      
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
            c_c_tag(:td, day)
          end
        }
      end
    } 
  end

end
