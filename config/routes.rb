Rails.application.routes.draw do
  get 'checks/index'
  post 'checks/check'

  get 'auth/login'
  get 'auth/callback'
  get 'auth/logout'
  get 'auth/orgs'
  put 'auth/org'

  root 'auth#login'
end
