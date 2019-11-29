class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.string :day_of_weeks
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
