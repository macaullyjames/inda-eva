class AuthController < ApplicationController
  skip_before_action :require_login, only: [:login, :callback, :logout]
  skip_before_action :require_org, only: [:login, :callback, :logout, :orgs]

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
    session[:username] = Octokit::Client.new(access_token: token).user.login
    session[:oauth_token] = token
    redirect_to auth_orgs_url
  end

  def logout
    reset_session
    redirect_to root_url
  end

  def org
    org = session[:org] = params[:org]
    if Repo.where(org: org).empty?
      user.remote.org_repos(org).each do |r|
        Repo.where(org: org, name: r.name).first_or_create
      end
    end
    redirect_to checks_index_url
  end

  def orgs
    @orgs = user.remote.orgs.map &:login
  end
end
