Rails.application.routes.draw do
  get 'auth/login'
  get 'auth/callback'
  get 'auth/logout'
  get 'auth/orgs'
  put 'auth/org'

  root 'auth#login'
end
