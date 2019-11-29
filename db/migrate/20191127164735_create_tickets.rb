class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :phone
      t.string :slug
      t.references :exhibition, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
