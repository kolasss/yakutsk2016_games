class AddDateToAttachments < ActiveRecord::Migration
  def up
    add_column :attachments, :date, :date, null: false, default: '2016-07-10'
    change_column_default(:attachments, :date, nil)
  end

  def down
    remove_column :attachments, :date
  end
end
