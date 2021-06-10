Rails.application.routes.draw do
  
  namespace :admin do
    get 'communities/index'
    get 'communities/show'
    get 'communities/edit'
  end
  namespace :public do
    get 'communities/new'
    get 'communities/index'
    get 'communities/show'
    get 'communities/edit'
  end
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'customers/men' => 'customers#men', as: 'men' # 男性会員一覧
    get 'customers/women' => 'customers#women', as: 'women' # 女性会員一覧
    
    resources :customers, only: [:show, :edit, :update, :destroy]
    resources :communities, except: [:new]
  end
  
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }
  
  scope module: :public do
    root 'homes#top'
    get 'customers/men' => 'customers#men', as: 'customer_men' # 男性会員一覧
    get 'customers/women' => 'customers#women', as: 'customer_women' # 女性会員一覧
    get 'customers/unsubscribe/:email' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/:id/withdraw/:email' => 'customers#withdraw', as: 'withdraw_customer'
    put 'customers/withdraw/:email' => 'customers#withdraw'
    get 'customers/followed' => 'relationships#followed', as: 'followed' # お気に入り一覧
    get 'customers/follower' => 'relationships#follower', as: 'follower' # お気に入りされた一覧
    get 'customers/matchers' => 'relationships#matchers', as: 'matchers' # 互いにお気に入りしている一覧
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
    resources :communities, except: [:destroy]
    resources :community_posts, only: [:create]
  end
end
