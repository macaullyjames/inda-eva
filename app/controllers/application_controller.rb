class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :require_org

  def client_id
    Rails.application.secrets.github_client_id
  end

  def client_secret
    Rails.application.secrets.github_client_secret
  end

  def user
    if token = session[:oauth_token]
      @user ||= OpenStruct.new(
        token: token,
        remote: Octokit::Client.new(access_token: token)
      )
    end
  end

  def org
    @org ||= session[:org]
  end

  def require_login
    unless user
      flash[:error] = "You must be logged in to access this section."
      redirect_to root_url
    end
  end

  def require_org
    unless org
      flash[:error] = "You must be logged in to an organization to access this section."
      redirect_to root_url
    end
  end
end
