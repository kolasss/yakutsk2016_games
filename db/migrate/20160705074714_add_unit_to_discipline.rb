class AddUnitToDiscipline < ActiveRecord::Migration
  def change
    add_column :disciplines, :unit, :string
  end
end
