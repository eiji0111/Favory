Rails.application.routes.draw do
  
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'

    resources :customers, only: [:show, :edit, :update, :destroy] do
      collection do
        get 'men' => 'customers#men' # 男性会員一覧
        get 'women' => 'customers#women' # 女性会員一覧
      end
    end
    resources :communities, except: [:new, :create]
    resources :army_requests, only: [:index, :show, :update]
  end
  
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords',
  }
  devise_scope :customer do
    post 'customers/guest_sign_in' => 'public/sessions#guest_sign_in', as: 'guest_sign_in' # ゲストログイン
  end
  
  scope module: :public do
    root 'homes#top'
    get 'homes/company_profile' => 'homes#company_profile', as: 'company_profile' # 会社概要
    get 'homes/teams_of_use' => 'homes#teams_of_use', as: 'teams_of_use' # 利用規約
    get 'homes/privacy_policy' => 'homes#privacy_policy', as: 'privacy_policy' # プライバシーポリシー
    post 'follow/:id' => 'relationships#follow', as: 'follow' # お気に入りする
    delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # お気に入りから外す

    resources :chats, only: [:show, :create]
    resources :communities, except: [:new, :destroy]
    resources :community_posts, only: [:create, :destroy]
    resources :army_requests, only: [:new, :create]
    resources :notifications, only: [:index]
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'men' => 'customers#men' # 男性会員一覧
        get 'women' => 'customers#women' # 女性会員一覧
        get 'followed' => 'relationships#followed' # お気に入り一覧
      end
      member do
        get 'unsubscribe' => 'customers#unsubscribe' # 退会確認画面
        patch 'withdraw' => 'customers#withdraw' # 退会処理
      end
    end
    resources :contacts, only: [:new, :create] do
      collection do
        post 'back' => 'contacts#back' # お問い合わせ確認画面へ戻る
        post 'confirm' => 'contacts#confirm'
        get 'confirm' => 'contacts#back'
        get 'complete' => 'contacts#complete'
      end
    end
  end
end
