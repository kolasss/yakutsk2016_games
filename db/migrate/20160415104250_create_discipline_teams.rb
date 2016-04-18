class CreateDisciplineTeams < ActiveRecord::Migration
  def change
    create_table :discipline_teams do |t|
      t.integer :rank, null: false, default: 9999

      t.references :discipline, index: true, foreign_key: true, null: false
      t.references :team, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :discipline_teams, [:discipline_id, :team_id]
  end
end
