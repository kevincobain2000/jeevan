Jeevan::Application.routes.draw do
  resources :blogs

  resources :others do
    collection do
      get :confirmbasic
      post :modify_gender
    end
  end
  get '/users/sign_up', to: redirect('/users/sign_in')
  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions", :omniauth_callbacks => "omniauth_callbacks"  }

  resources :profiles do
    collection do
      delete :destroy_everything
      post :modify_profile
      post :modify_avatar
      post :modify_contact
      post :modify_religion
      post :modify_kundali
      post :modify_about
      post :modify_hobby
      post :modify_family
      post :modify_education
      post :modify_occupation
      post :modify_lifestyle
      post :modify_desire
      post :modify_image
      post :remove_image
      post :remove
      post :interest
      post :interest_response
      post :shortlist
      post :search
      post :search_advanced
      post :index
      #ajax
      post :get_selectize
      #other gets
      get :incomings
      get :outgoings
      get :visitors
      get :waiting
      get :shortlists
      get :accepted
      get :online
      get :withphotos
      get :recentlyjoined
    end
  end
  resources :profile do
    collection do
    end
  end
  resources :messages do
    collection do
      post :send_message
    end
  end

  resources :contact do
    collection do
    end
  end

  get "home/index"
  authenticated :user do
    root :to => 'profiles#index', :as => :authenticated_root
  end

  root :to => redirect('/users/sign_in')

  get '*path' => redirect('/')
end
