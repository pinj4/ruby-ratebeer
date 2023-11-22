class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
    if user&.authenticate(params[:password])
      if user.active
        session[:user_id] = user.id
        redirect_to user, notice: "Welcome back!"
      else
        redirect_to signin_path, notice: "Your account is closed, please contact with admin"
      end
    else
      redirect_to signin_path, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
