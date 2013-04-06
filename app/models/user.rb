class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attr_accessible :email

  validates :email, :access_token, presence: true
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX }

  def self.access_token_exists?(token)
    where(access_token: token).any?
  end

  def generate_access_token_and_save
    Notification.auth_link(self).deliver if generate_access_token and save
  end

  private
    def generate_access_token
      loop do
        token = SecureRandom.hex(30)
        return self.access_token = token unless User.access_token_exists?(token)
      end
    end

end
