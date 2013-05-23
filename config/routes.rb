Median::Application.routes.draw do

  get "searches/create"

# Single resource

resource :session
resource :account
resource :search

resources :users
resources :categories

resources :posts do
	resource :like
	resources :user_comments, path: "comments"
	end	

root to: "posts#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

end
