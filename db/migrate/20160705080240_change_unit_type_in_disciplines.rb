class ChangeUnitTypeInDisciplines < ActiveRecord::Migration
  def change
    remove_column :disciplines, :unit
    add_column :disciplines, :unit, :jsonb, default: '{}'
  end
end
