class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :rank

      t.references :discipline, index: true, foreign_key: true, null: false
      t.references :country, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :teams, [:discipline_id, :country_id]
  end
end
