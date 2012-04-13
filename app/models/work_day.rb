class WorkDay < ActiveRecord::Base
  attr_accessible :day, :end_work, :note, :start_work
end
