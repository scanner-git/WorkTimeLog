class WorkDay < ActiveRecord::Base
  attr_accessible :day, :end_work, :note, :start_work

  scope :in_month, lambda{|timerange| where(:day => timerange)}   # neu
end
