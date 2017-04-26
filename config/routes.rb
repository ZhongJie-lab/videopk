Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'battles#index'

  get 'about' => 'battles#about'

  get 'contact' => 'battles#contact'

  resources :battles do
    member do
      post :follow_left_video
      post :unfollow_left_video
      post :follow_right_video
      post :unfollow_right_video
    end

    # resources :videos do
    #   resources :video_comments, only: [:new, :create]
    # end
    resources :battle_comments, only: [:new, :create]
  end

  namespace :admin do
    resources :videos do
      #resources :video_comments
    end

    resources :battles do
      resources :battle_comments
    end

    resources :users
  end
  namespace :api do
    namespace :v1 do
      resources :battles do
        member do
          post :follow_left_video
          post :unfollow_left_video
          post :follow_right_video
          post :unfollow_right_video
        end

    # resources :videos do
    #   resources :video_comments, only: [:new, :create]
    # end
      resources :battle_comments, only: [:new, :create]
      end
    end
  end
end
