Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    resources :users, only: [:show, :edit, :update] do
      member do
        get :withdraw_check # 退会確認画面
        patch :withdraw_update # ステータス更新
      end
    end
    resources :quizzes, only: [:create] do
      member do
        get 'quiz'
        post 'answer'
        get 'answer'
      end
      resources :bookmarks, only: [:index, :create, :destroy] do
        member do
          get 'quiz'
          post 'answer'
          get 'answer'
        end
      end
      resources :quiz_comments, only: [:create, :destroy]
    end
    get "/search", to: "searches#search"
    resources :searches, only: [:index] do
      member do
        get 'quiz'
        post 'answer'
        get 'answer'
      end
    end
    root to: 'homes#top'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :quizzes, only: [:index, :new, :create, :show, :edit, :update]
  end

end
