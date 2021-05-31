Rails.application.routes.draw do
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'contacts/new'
    get 'contacts/confirm'
    get 'contacts/complete'
  end
  namespace :public do
    get 'chats/show'
  end
  namespace :public do
    get 'relationships/followed'
    get 'relationships/follow'
    get 'relationships/unfollow'
  end
  namespace :public do
    get 'homes/top'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
