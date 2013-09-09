class User < ActiveRecord::Base
 
   attr_accessible :name, :email, :password, :password_confirmation, :web, :phone
   

has_many :authorizations


  before_save { |user| user.email = email.downcase unless user.email.blank? }
  before_save :create_remember_token
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # validates :email, presence:   true,
                    # format:     { with: VALID_EMAIL_REGEX },
                    # uniqueness: { case_sensitive: false }
  
 
before_create { generate_token(:auth_token) } 

def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
  unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  end
end 
 def send_email_confirm(user)
   UserMailer.registration_confirmation(user)
   
 end 
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
# def self.from_omniauth(auth)
    # where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      # user.provider = auth.provider
      # user.uid = auth.uid
      # user.email= auth.info.email
      # user.phone= auth.info.phone
      # user.name = auth.info.name
      # user.oauth_token = auth.credentials.token
      # user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      # user.save!
    # end
  # end
    private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
