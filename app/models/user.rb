class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attr_accessible :email

  validates :email, :access_token, presence: true
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX }

  def self.access_token_exists?(token)
    where(access_token: token).any?
  end
end
