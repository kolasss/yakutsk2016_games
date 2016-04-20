class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :published_at

      t.integer :parent_id
      t.integer :sort_order

      t.references :location, index: true, foreign_key: true, null: false
      t.references :discipline, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :contests, :parent_id
    add_foreign_key :contests, :contests, column: :parent_id
  end
end
