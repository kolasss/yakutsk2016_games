class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.jsonb :info

      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
