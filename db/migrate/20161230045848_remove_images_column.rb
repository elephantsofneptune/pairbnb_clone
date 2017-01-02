class RemoveImagesColumn < ActiveRecord::Migration
  def change
    remove_column :listings, :images
    add_column :listings, :images, :json
  end
end
