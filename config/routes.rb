Rails.application.routes.draw do
  
  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'customers/men' => 'customers#men', as: 'men' # 男性会員一覧
    get 'customers/women' => 'customers#women', as: 'women' # 女性会員一覧
    
    resources :customers, only: [:show, :edit, :update]
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
    post 'follow/:id' => 'relationships#follow', as: 'follow' # お気に入りする
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # お気に入りから外す
    get 'chat/:id' => 'chats#show', as: 'chat'
    post 'contacts/back' => 'contacts#back', as: 'back_contact' # お問い合わせ確認画面へ戻る
    post 'contacts/confirm' => 'contacts#confirm', as: 'confirm_contact'
    get 'contacts/complete' => 'contacts#complete', as: 'complete_contact'
    
    resources :customers, only: [:show, :edit, :update]
    resources :chats, only: [:create]
    resources :contacts, only: [:new, :create]
  end
end
