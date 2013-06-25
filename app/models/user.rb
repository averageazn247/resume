class User < ActiveRecord::Base
 
   attr_accessible :name, :email, :password, :password_confirmation, :web, :phone
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
 
before_create { generate_token(:auth_token) }
def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  UserMailer.password_reset(self).deliver
end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

    private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
