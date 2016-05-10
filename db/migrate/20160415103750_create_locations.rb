class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.jsonb :name, null: false, default: '{}'
      t.jsonb :address, default: '{}'
      t.jsonb :info, default: '{}'
      t.string :photo

      t.timestamps null: false
    end
  end
end
