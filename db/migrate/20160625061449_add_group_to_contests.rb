class AddGroupToContests < ActiveRecord::Migration
  def change
    add_column :contests, :in_group, :boolean, default: false
    add_column :contests, :group_id, :integer
  end
end
