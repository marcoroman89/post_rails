class PagesController < ApplicationController
  before_action :require_user, only: [:home]
  def home
    
  end

  def about
    
  end

  private
  def require_user
    access_denied_homepage if logged_in?
  end

  def access_denied_homepage
    redirect_to posts_path
  end

end  