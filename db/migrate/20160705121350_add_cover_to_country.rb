class AddCoverToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :cover, :string
  end
end
