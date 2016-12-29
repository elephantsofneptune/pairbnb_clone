class AddCountryAndLocationColumn < ActiveRecord::Migration
  def change
    add_column :listings, :country, :string, index: true
    add_column :listings, :address, :string, index: true
  end
end
