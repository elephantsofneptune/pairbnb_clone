class ListingAttachment < ActiveRecord::Base

   validates :image, presence: true
   validates :listing_id, presence: true

   belongs_to :listing
   mount_uploader :image, ImageUploader
end
