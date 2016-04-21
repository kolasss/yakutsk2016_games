class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.jsonb :name, null: false, default: '{}'
      t.boolean :finished, default: false, null: false

      t.references :sport, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
