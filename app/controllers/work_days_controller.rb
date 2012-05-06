
class WorkDaysController < ApplicationController
  # GET /work_days
  # GET /work_days.json
  def index
    #@work_days = WorkDay.all()
    #if params[:wtm]
    #  @work_month_time = Time.now
    #else
    #  @work_month_time = Time.now
    #end
    #@mon = Date.new(@mon)
    @work_days = WorkDay.in_month(month_from_beginnig_week_to_end_week(@mon, range: true, date: true))
    @work_days_hash = create_calendar_month_hash @work_days
    @week_days_array = wdays_array_for_month(@mon)

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
    
    if params[:day]
      @work_day = WorkDay.new(day: params[:day].to_date)
    else
      @work_day = WorkDay.new
    end

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
        format.html { redirect_to work_days_path, notice: 'Work day was successfully created.' }
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

  def test
    
  end

  private

  # Erzeugt aus übergebenen WorkDay Array ein Hash mit dem Datum als Schlüssel
  # und dem WorkDay Objekt als Wert.
  # Parameter: [WorkDay]
  def create_calendar_month_hash work_days
    work_days_hash = Hash.new("XXX")
    work_days.each do |i| 
      work_days_hash[i.day] = i
    end
    work_days_hash
  end


  def month_from_beginnig_week_to_end_week(date, param=Hash.new)
    start_month =date.beginning_of_month
    end_month = date.end_of_month
    start_date = start_month.beginning_of_week
    end_date = end_month.end_of_week
    return start_date.to_date..end_date.to_date if (param[:date] == true && param[:range] == true)
    return start_date..end_date if param[:range] == true
    return [start_date.to_date, end_date.to_date] if param[:date] == true
    return [start_date, end_date]
  end

  def wdays_array_for_month time
    days = Array.new
    week = Hash.new
    start_and_end_time = month_from_beginnig_week_to_end_week time  
    time_iterate(start_and_end_time[0], start_and_end_time[1], 1.day){ |i|
      week[i.wday] = i
      if i.wday == 0
        days << week
        week = Hash.new
      end
    }
    days
  end

  def time_iterate(start_time, end_time, step, &block)
    begin
      yield(start_time)
    end while (start_time += step) <= end_time
  end

end
