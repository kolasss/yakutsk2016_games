class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.string :name, null: false
      t.boolean :finished, default: false, null: false

      t.references :sport, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
