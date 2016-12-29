class Listing < ActiveRecord::Base
        

    enum status: {pending: 0, approved: 1, denied: 2}

    before_create :set_default_status

    # ========= validations
    validates :title, presence: true
    validates :description, presence: true
    validates :country, presence: true
    validates :address, presence: true
    validates :pax, presence: true
    validates :user_id, presence: true


    # ========= relations
    has_many :reservations, dependent: :destroy
    belongs_to :user

    # ========= taggable
    acts_as_taggable

    mount_uploader :image, ImageUploader

    def set_default_status
      self.status ||= :pending
    end
end