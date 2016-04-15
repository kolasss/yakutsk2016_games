class AthleteDisciplineTeamJoinTable < ActiveRecord::Migration
  def change
    create_table :athletes_discipline_teams, id: false do |t|
      t.references :athlete, index: true, foreign_key: true, null: false
      t.references :discipline_team, index: true, foreign_key: true, null: false
    end

    add_index :athletes_discipline_teams, [:athlete_id, :discipline_team_id], unique: true, name: 'index_athletes_discipline_teams'
  end
end
