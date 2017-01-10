class Listing < ActiveRecord::Base

  # STATUS =================================
  enum status: {pending: 0, approved: 1, denied: 2}

  # BEFORE_CREATE ==========================
  before_create :set_default_status

  # VALIDATION =============================
  validates :title, presence: true
  validates :description, presence: true
  validates :country, presence: true
  validates :address, presence: true
  validates :pax, presence: true
  validates :user_id, presence: true

  # RELATIONS ==============================
  has_many :reservations, dependent: :destroy
  has_many :listing_attachments, dependent: :destroy
  belongs_to :user

  # TAGGABLE ===============================
  acts_as_taggable

  # LISTING ATTACHMENT NESTED ATTR =========
  accepts_nested_attributes_for :listing_attachments

  # SCOPES =================================
  scope :approved,  ->{ where("status = ?", 1) }
  scope :pending,  ->{ where("status = ?", 0) }
  scope :denied,  ->{ where("status = ?", 2) }

  scope :recent,    ->{ order("created_at DESC") }

  scope :country,   ->(name){ where("country = ?", "#{name}") }
  scope :pax,       ->(pax){ where("pax = ?", pax) }
  scope :price,     ->(price){ where("price <= ?", price)}


  # DEFAULT WHEN CREATED ===================
  def set_default_status
    self.status ||= :pending
  end

end
