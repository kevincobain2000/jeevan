Jeevan::Application.routes.draw do
  resources :others do
    collection do
      get :confirmemail
    end
  end
  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions" }
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
      post :modify_occupation
      post :modify_lifestyle
      post :modify_desire
      post :modify_image
      post :remove_image
      post :remove
      post :interest
      post :interest_response
      post :shortlist
      post :seen_notification
      post :search
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

  resources :dashboard do
    collection do
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

  if Rails.env.production?
    get '*path' => redirect('/')
  end
  get '*path' => redirect('/')
end
