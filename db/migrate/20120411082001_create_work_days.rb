class CreateWorkDays < ActiveRecord::Migration
  def change
    create_table :work_days do |t|
      t.date :day
      t.time :start_work
      t.time :end_work
      t.text :note

      t.timestamps
    end
  end
end
