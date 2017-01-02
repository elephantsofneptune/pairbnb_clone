class CreateListingAttachments < ActiveRecord::Migration
  def change
    create_table :listing_attachments do |t|
      t.integer :post_id
      t.string :image

      t.timestamps null: false
    end
  end
end
