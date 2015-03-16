class User < ActiveRecord::Base
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  private

  attr_reader :password
end