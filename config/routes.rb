Rails.application.routes.draw do
#  root :to => 'admin/admin#index'
  root :to => 'home#index'
  mount Ckeditor::Engine => 'ckeditor'

  devise_for :admins, :controllers => { :sessions => "admins/sessions",:registrations => "admins/registrations" }, :path_names =>  {:sign_up=>'new',:sign_in => 'login', :sign_out => 'logout'} do
    get 'edit', :to => 'admins::Registrations#edit'
    get 'login', :to => 'admins::Sessions#new'
    get 'logout', :to=> 'admins::Sessions#destroy'
  end

  devise_for :users, :controllers => { :sessions => "users/sessions",:registrations => "users/registrations",:passwords => "users/passwords" }, :path_names =>  {:sign_up=>'new',:sign_in => 'login', :sign_out => 'logout'} do
    get 'new', :to => 'users::Registrations#new'
    get 'edit', :to => 'users::Registrations#edit'
    get 'login', :to => 'users::Sessions#new'
    get 'logout', :to=> 'users::Sessions#destroy'
  end

  get 'home/popup'=>'home#popup'
  resources :notices
  resources :recommends    
  resources :devices
  resources :users, only: [:new, :index, :edit]

  # 관리자
  scope 'admin', module: 'admin', as: 'admin' do
    get '/' => 'admin_home#index'
    resources :recommends    
    resources :notices    
    resources :groups
    resources :devices
    resources :push_messages
    resources :push_prepare_pictures do
      collection do
        get 'id_select'
        get 'id_select_search_result'
      end
    end
    resources :push_prepare_messages do
      collection do
        get 'id_select'
        get 'id_select_search_result'
      end
    end

    resources :operators
    resources :users do
      collection do
        get 'user_id_select'
        get 'user_id_select_search_result'
        post 'download_agreement'
        delete 'destroy_multiple'
        post 'export_csv'
      end
    end
  end
end
