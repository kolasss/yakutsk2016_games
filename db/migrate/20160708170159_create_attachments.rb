class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.jsonb :title, null: false, default: '{}'
      t.string :file
      t.jsonb :meta, null: false, default: '{}'

      t.references :sport, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
