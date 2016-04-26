class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.jsonb :name, null: false, default: '{}'
      t.string :flag
      t.jsonb :info, default: '{}'
      t.integer :gold_count, default: 0, null: false
      t.integer :silver_count, default: 0, null: false
      t.integer :bronze_count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
