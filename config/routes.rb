Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]

  
  # Use scope to set the URL path without affecting the controller's expected namespace
  scope '/api/v1', as: 'api_v1' do
    devise_scope :user do
      post 'sign_up', to: 'users/registrations#create', as: :user_registration
      post 'sign_in', to: 'users/sessions#create', as: :user_session
      delete 'sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
    end
  end
end
