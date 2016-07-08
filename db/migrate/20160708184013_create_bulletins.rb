class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.jsonb :title, null: false, default: '{}'
      t.string :file
      t.date :date, null: false
      t.jsonb :meta, null: false, default: '{}'

      t.timestamps null: false
    end
  end
end
