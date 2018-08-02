Rails.application.routes.draw do

  def api_version(version, &routes)
    namespace :api, defaults: { format: :json } do
      namespace("v#{version}", &routes)
    end
  end

  api_version(1) do
    resources :lists do
      post :assign_member, on: :member
      post :unassign_member, on: :member
      resources :cards
    end
    post 'signup', to: 'users#signup'
    post 'admin/signup', to: 'users#signup'
    post 'login', to: 'users#login'
    delete 'logout', to: 'users#logout'
  end
end
