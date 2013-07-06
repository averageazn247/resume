class SessionsController < ApplicationController
    def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
       cookies.permanent[:auth_token] = user.auth_token
      session[:user_id] = user.id
       sign_in user
      redirect_to user
    elsif User.from_omniauth(env["omniauth.auth"])
      user=User.from_omniauth(env["omniauth.auth"])
         session[:user_id] = user.id
    redirect_to root_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:auth_token)
        sign_out
    redirect_to root_url
  end
  
end
