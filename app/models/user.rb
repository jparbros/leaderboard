class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  include Mailchimp

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { medium: "300x300>", thumb: "95x95>", small: '30x30' }, :default_url => ActionController::Base.helpers.asset_path(':style-missing.png')
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

  def create_password_token_reset
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)

    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    self.save(validate: false)
    raw
  end

  protected

  # NOTE: ensure that fragment comes AFTER querystring for proper $location
  # parsing using AngularJS.
  def generate_url(url, params = {})
    uri = URI(url)

    res = "#{uri.scheme}://#{uri.host}"
    res += ":#{uri.port}" if (uri.port and uri.port != 80 and uri.port != 443)
    res += "#{uri.path}" if uri.path
    res += "#{uri.fragment}" if uri.fragment
    res += "?#{params.to_query}"

    return res
  end
end
