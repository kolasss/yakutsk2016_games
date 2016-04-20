class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :name, null: false
      t.string :photo
      t.text :info

      t.references :country, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
