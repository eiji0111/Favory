Rails.application.routes.draw do
  
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'customers/men' => 'customers#men', as: 'men' # 男性会員一覧
    get 'customers/women' => 'customers#women', as: 'women' # 女性会員一覧
    
    resources :customers, only: [:show, :edit, :update, :destroy]
    resources :communities, except: [:new, :create]
    resources :army_requests, only: [:index, :show, :update]
  end
  
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords',
  }
  
  scope module: :public do
    root 'homes#top'
    get 'homes/teams_of_use' => 'homes#teams_of_use', as: 'teams_of_use' # 利用規約
    get 'homes/privacy_policy' => 'homes#privacy_policy', as: 'privacy_policy' # プライバシーポリシー
    get 'customers/men' => 'customers#men', as: 'customer_men' # 男性会員一覧
    get 'customers/women' => 'customers#women', as: 'customer_women' # 女性会員一覧
    get 'customers/unsubscribe/:id' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    put 'customers/withdraw/:id' => 'customers#withdraw'
    get 'customers/followed' => 'relationships#followed', as: 'followed' # お気に入り一覧
    post 'follow/:id' => 'relationships#follow', as: 'follow' # お気に入りする
    delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # お気に入りから外す
    get 'chat/:id' => 'chats#show', as: 'chat'
    delete 'chat/:id' => 'chats#destroy', as: 'chat_destroy'
    post 'contacts/back' => 'contacts#back', as: 'back_contact' # お問い合わせ確認画面へ戻る
    post 'contacts/confirm' => 'contacts#confirm', as: 'confirm_contact'
    get 'contacts/confirm' => 'contacts#back', as: 'back'
    get 'contacts/complete' => 'contacts#complete', as: 'complete_contact'

    resources :customers, only: [:show, :edit, :update]
    resources :chats, only: [:create]
    resources :contacts, only: [:new, :create]
    resources :communities, except: [:new, :destroy]
    resources :community_posts, only: [:create, :destroy]
    resources :army_requests, only: [:new, :create]
    resources :notifications, only: [:index]
  end
end
