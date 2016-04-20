class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :flag
      t.text :info

      t.timestamps null: false
    end
  end
end
