class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |t|
      t.references :athlete, index: true, foreign_key: true, null: false
      t.references :team, index: true, foreign_key: true, null: false
    end

    add_index :team_memberships, [:athlete_id, :team_id], unique: true
  end
end
