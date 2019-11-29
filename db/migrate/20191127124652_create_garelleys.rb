class CreateGarelleys < ActiveRecord::Migration[5.2]
  def change
    create_table :garelleys do |t|
      t.string :name
      t.text :image

      t.timestamps
    end
  end
end
