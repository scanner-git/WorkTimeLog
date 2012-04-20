class AddIndexToWorkDays < ActiveRecord::Migration
  def change
  	add_index :work_days, :day, unique: true
  end
end
