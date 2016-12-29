class User < ActiveRecord::Base
   
  include Clearance::User
  
  enum role: {user: 0, moderator: 1, superadmin: 2}
  
  before_save :set_default_role

  # ============ validation
  validates :name, presence: true

  # ============ relations
  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy

  has_many :authentications, dependent: :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = User.create(name: auth_hash["extra"]["raw_info"]["name"], email: auth_hash["extra"]["raw_info"]["email"])
    user.authentications<<(authentication)
    return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

  def set_default_role
    self.role ||= :user
  end

end

  # def self.create_with_auth_and_hash(authentication, auth_hash)
  #   create! do |u|
  #     u.name = auth_hash["extra"]["raw_info"]["name"]
  #     u.email = auth_hash["extra"]["raw_info"]["email"]
  #     u.authentications<<(authentication)
  #   end
  # end

