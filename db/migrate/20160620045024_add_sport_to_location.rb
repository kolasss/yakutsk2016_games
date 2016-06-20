class AddSportToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :sport, :boolean, default: false, null: false
  end
end
