class CreateDisciplineTeamMemberships < ActiveRecord::Migration
  def change
    create_table :discipline_team_memberships do |t|
      t.references :athlete, index: true, foreign_key: true, null: false
      t.references :discipline_team, index: true, foreign_key: true, null: false
    end

    add_index :discipline_team_memberships, [:athlete_id, :discipline_team_id], unique: true, name: 'index_athletes_discipline_teams_membership'
  end
end
