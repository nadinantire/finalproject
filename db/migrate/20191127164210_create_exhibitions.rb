class CreateExhibitions < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibitions do |t|
      t.text :name
      t.time :start_time
      t.time :end_time
      t.text :image
      t.date :date

      t.timestamps
    end
  end
end
