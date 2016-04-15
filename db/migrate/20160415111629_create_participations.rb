class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.string :score
      t.boolean :win, default: false, null: false

      t.references :discipline_team, index: true, foreign_key: true, null: false
      t.references :event, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :participations, [:discipline_team_id, :event_id], unique: true
  end
end
