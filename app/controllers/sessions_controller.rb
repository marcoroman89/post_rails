class SessionsController < ApplicationController
  def new
    # Handles the creat new login template
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you're logged in!"
      redirect_to posts_path
    else
      flash[:error] = "Oops, something is wrong with your username or password!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out, see you soon!"
    redirect_to root_path
  end
end  