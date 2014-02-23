Jeevan::Application.routes.draw do

  resources :expresses

  resources :profiles do
    collection do
      post :modify_profile
      post :modify_avatar
      post :modify_contact
      post :modify_religion
      post :modify_kundali
      post :modify_about
      post :modify_hobby
      post :modify_family
      post :modify_education
      post :modify_lifestyle
      post :modify_desire
      post :modify_image
      post :remove_image
      post :remove
      post :interest
      post :interest_response
    end
  end

  get "home/index"
  resources :visitors
  devise_for :users
  authenticated :user do
    root :to => 'profiles#index', :as => :authenticated_root
  end
  root :to => redirect('/users/sign_in')
end
