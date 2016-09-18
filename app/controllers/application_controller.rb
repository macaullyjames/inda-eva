class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def client_id
    Rails.application.secrets.github_client_id
  end

  def client_secret
    Rails.application.secrets.github_client_secret
  end

  def user
    if session[:oauth_token]
      @user ||= OpenStruct.new token: session[:oauth_token]
    end
  end

  def require_login
    unless user
      flash[:error] = "You must be logged in to access this section."
      redirect_to root_url
    end
  end
end
