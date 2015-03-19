class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

end
