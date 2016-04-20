class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.text :info

      t.references :location, index: true, foreign_key: true, null: false
      t.references :sport, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
