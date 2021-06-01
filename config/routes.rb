Rails.application.routes.draw do
  
  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    
    resources :customers, only: [:index, :show, :edit, :update]
  end
  
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }
  
  scope module: :public do
    root 'homes#top'
    get 'customers/unsubscribe/:name' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/:id/withdraw/:name' => 'customers#withdraw', as: 'withdraw_customer'
    put 'customers/withdraw/:name' => 'customers#withdraw'
    get 'customers/followed' => 'relationships#followed', as: 'followed' # お気に入り一覧
    post 'follow/:id' => 'relationships#follow', as: 'follow' # お気に入りする
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # お気に入りから外す
    get 'chat/:id' => 'chats#show', as: 'chat'
    post 'contacts/back' => 'contacts#back', as: 'back_contact' # お問い合わせ確認画面へ戻る
    get 'contacts/confirm' => 'contacts#confirm', as: 'confirm_contact'
    get 'contacts/complete' => 'contacts#complete', as: 'complete_contact'
    
    resources :customers, only: [:index, :show, :edit, :update]
    resources :chats, only: [:create]
    resources :contacts, only: [:new, :create]
  end
end
