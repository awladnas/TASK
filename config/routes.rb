Rails.application.routes.draw do

  def api_version(version, &routes)
    namespace :api, defaults: { format: :json } do
      namespace("v#{version}", &routes)
    end
  end

  api_version(1) do
    resources :cards
    resources :lists
    post 'signup', to: 'users#signup'
    post 'login', to: 'users#login'
  end
end
