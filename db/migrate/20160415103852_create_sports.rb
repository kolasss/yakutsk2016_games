class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.jsonb :name, null: false, default: '{}'
      t.string :icon
      t.jsonb :info, default: '{}'

      t.timestamps null: false
    end
  end
end
