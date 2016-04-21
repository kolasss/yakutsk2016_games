class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.jsonb :name, null: false, default: '{}'
      t.string :flag
      t.jsonb :info, default: '{}'

      t.timestamps null: false
    end
  end
end
