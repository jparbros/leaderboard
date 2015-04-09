class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { medium: "300x300>", thumb: "95x95>", small: '30x30' }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  belongs_to :organization
  belongs_to :departament
  has_many :inputs

  serialize :target, Hash

  accepts_nested_attributes_for :organization,
      allow_destroy: true,
      reject_if: :all_blank

  def confirmed?
   true
  end

  def set_password
    @password = SecureRandom.hex(8)
    password = @password
    password_confirmation = @password
  end

  def token_validation_response
    UserSerializer.new(self).as_json(root: false)
  end
end
