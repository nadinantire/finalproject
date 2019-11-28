class CreateArtifacts < ActiveRecord::Migration[5.2]
  def change
    create_table :artifacts do |t|
      t.string :name
      t.string :image
      t.text :description
      t.references :category, foreign_key: true
      t.text :amount

      t.timestamps
    end
  end
end
