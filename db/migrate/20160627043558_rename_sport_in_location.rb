class RenameSportInLocation < ActiveRecord::Migration
  def change
    rename_column :locations, :sport, :for_sport
  end
end
