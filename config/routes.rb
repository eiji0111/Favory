Rails.application.routes.draw do
  
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
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
    get 'customers/my_page' => 'customers#show', as: 'mypage'
    get 'customers/edit' => 'customers#edit', as: 'edit_customer'
    patch 'customers/update' => 'customers#update', as: 'update_customer'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    get 'customers/:id/followed' => 'relationships#followed', as: 'followed' # お気に入り一覧
    post 'follow/:id' => 'relationships#follow', as: 'follow' # お気に入りする
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # お気に入りから外す
    get 'chat/:id' => 'chats#show', as: 'chat'
    post 'contacts/back' => 'contacts#back', as: 'back_contact' # お問い合わせ確認画面へ戻る
    get 'contacts/confirm' => 'contacts#confirm', as: 'confirm_contact'
    get 'contacts/complete' => 'contacts#complete', as: 'complete_contact'
    
    resources :customers, only: [:index]
    resources :chats, only: [:create]
    resources :contacts, only: [:new, :create]
  end
end
