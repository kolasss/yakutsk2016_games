class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :published_at

      t.string :path
      t.integer :depth
      t.integer :position
      t.integer :parent_id
      t.integer :children_count

      t.references :location, index: true, foreign_key: true, null: false
      t.references :discipline, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :events, :parent_id
    add_foreign_key :events, :events, column: :parent_id
  end
end
