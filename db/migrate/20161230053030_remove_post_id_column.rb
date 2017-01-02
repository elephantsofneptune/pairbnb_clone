class RemovePostIdColumn < ActiveRecord::Migration
  def change
    remove_column :listing_attachments, :post_id
    add_column :listing_attachments, :listing_id, :integer
  end
end
