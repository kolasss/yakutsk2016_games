class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.string :score
      t.integer :rank

      t.references :team, index: true, foreign_key: true, null: false
      t.references :contest, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :participations, [:team_id, :contest_id], unique: true
  end
end
