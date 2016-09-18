class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def client_id
    Rails.application.secrets.github_client_id
  end

  def client_secret
    Rails.application.secrets.github_client_secret
  end
end
