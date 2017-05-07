class User
  include Mongoid::Document
  include Mongoid::Timestamps

  TOKEN_DELIMITER = ':'

  before_save :ensure_auth_token



  # Get Public Auth Token
  def authentication_token
    "#{id}#{TOKEN_DELIMITER}#{self.auth_token}"
  end


  # Authenticate User by Token
  def self.authenticate(token)
    if token
      id, token = token.split(TOKEN_DELIMITER)
      user = User.where(id: id).first

      if user && Devise.secure_compare(user.auth_token, token)
        user
      else
        false
      end

    else
      false
    end
  end


  # Ensure it exists
  def ensure_auth_token
    if auth_token.blank?
      self.auth_token = generate_auth_token
    end
  end



  private

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(auth_token: token).first
    end
  end



  ## Devise Configuration ##################################################

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :auth_token,         type: String

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
end
