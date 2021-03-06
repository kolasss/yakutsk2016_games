class CreateContestHierarchies < ActiveRecord::Migration
  def change
    create_table :contest_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :contest_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "contest_anc_desc_idx"

    add_index :contest_hierarchies, [:descendant_id],
      name: "contest_desc_idx"
  end
end
