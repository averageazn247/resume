OmniAuth.config.logger = Rails.logger
OmniAuth.config.on_failure = UsersController.action(:oauth_failure)
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,  '612482575446579' ,  '914683279181f5cece9b378937da9a9d' 
end