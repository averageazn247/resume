class ApplicationController < ActionController::Base
  protect_from_forgery
    include SessionsHelper
 private
  def current_user
    @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user
  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
