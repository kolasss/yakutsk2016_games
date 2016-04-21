class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.jsonb :name, null: false, default: '{}'
      t.string :photo
      t.jsonb :info, default: '{}'

      t.references :country, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
