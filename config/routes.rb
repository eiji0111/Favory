Rails.application.routes.draw do
  
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
  end
  
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }
  
  scope module: :public do
    root 'homes#top'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    get 'users/:id/followed' => 'relationships#followed', as: 'followed' # お気に入り一覧
    post 'follow/:id' => 'relationships#follow', as: 'follow' # お気に入りする
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # お気に入りから外す
    get 'contacts/confirm' => 'contacts#confirm', as: 'confirm'
    get 'contacts/complete' => 'contacts#complete', as: 'complete'
    
    resources :chats, only: [:create, :show]
    resources :contacts, only: [:new, :create]
  end
end
