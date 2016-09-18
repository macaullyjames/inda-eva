class AuthController < ApplicationController
  skip_before_action :require_login, only: [:login, :callback, :logout]

  def login
    @login_redirect_url = Octokit::Client.new.authorize_url(
      client_id,
      redirect_uri: auth_callback_url,
      scope: "email repo admin:org admin:repo_hook"
    )
  end

  def callback
    token = Octokit.exchange_code_for_token(
      params[:code],
      client_id,
      client_secret
    ).access_token
    session[:oauth_token] = token
    redirect_to auth_orgs_url
  end

  def logout
    reset_session
    redirect_to root_url
  end

  def org
  end

  def orgs
  end
end
