class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attr_accessible :email

  validates :email, :access_token, presence: true
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX }

  def self.access_token_exists?(token)
    where(access_token: token).any?
  end

  def self.generate_token
    loop do
      token = SecureRandom.hex(30)
      return token unless User.access_token_exists?(token)
    end
  end
end
