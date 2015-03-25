class User < ActiveRecord::Base
  before_validation :ensure_session_token

  validates :name, :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }

  has_many(
    :questions,
    class_name: 'Question',
    foreign_key: :author_id
  )

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = find_by_email(email)
    user && user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private

  attr_reader :password

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end