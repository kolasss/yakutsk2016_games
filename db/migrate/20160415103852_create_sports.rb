class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.jsonb :name, null: false, default: '{}'
      t.string :icon
      t.jsonb :info, default: '{}'
      t.integer :format, default: 0, null: false

      t.references :location, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
