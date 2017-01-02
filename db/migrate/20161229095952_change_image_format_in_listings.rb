class ChangeImageFormatInListings < ActiveRecord::Migration
  def change
    remove_column :listings, :image
    add_column :listings, :images, :string, array: true, default: []
  end
end
