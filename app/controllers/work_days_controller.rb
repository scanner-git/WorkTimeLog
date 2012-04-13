
class WorkDaysController < ApplicationController

  # GET /work_days
  # GET /work_days.json
  def index
    # TEST
    @work_days = WorkDay.all()
    @work_days_hash = create_calendar_month_hash @work_days
    @week_days_array = wdays_array_for_month(Time.now)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @work_days }
    end
  end

  # GET /work_days/1
  # GET /work_days/1.json
  def show
    @work_day = WorkDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work_day }
    end
  end

  # GET /work_days/new
  # GET /work_days/new.json
  def new
    @work_day = WorkDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work_day }
    end
  end

  # GET /work_days/1/edit
  def edit
    @work_day = WorkDay.find(params[:id])
  end

  # POST /work_days
  # POST /work_days.json
  def create
    @work_day = WorkDay.new(params[:work_day])

    respond_to do |format|
      if @work_day.save
        format.html { redirect_to @work_day, notice: 'Work day was successfully created.' }
        format.json { render json: @work_day, status: :created, location: @work_day }
      else
        format.html { render action: "new" }
        format.json { render json: @work_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /work_days/1
  # PUT /work_days/1.json
  def update
    @work_day = WorkDay.find(params[:id])

    respond_to do |format|
      if @work_day.update_attributes(params[:work_day])
        format.html { redirect_to @work_day, notice: 'Work day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_days/1
  # DELETE /work_days/1.json
  def destroy
    @work_day = WorkDay.find(params[:id])
    @work_day.destroy

    respond_to do |format|
      format.html { redirect_to work_days_url }
      format.json { head :no_content }
    end
  end

  private

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

end
