class User < ActiveRecord::Base
  before_validation :ensure_session_token

  validates :name, :email, :password, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token = self.class.generate_session_token
  end

  private

  attr_reader :password
end