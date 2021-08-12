Rails.application.routes.draw do

  
  resources :kinds
  root "welcome#index"
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_up', to: 'users/registrations#new'
    get 'forgot_password', to: 'users/passwords#new'
    get 'reset_password', to: 'users/passwords#edit'
  end  
  
  resources :students
  resources :statusapps
  get 'students/import'
  resources :students do
  	collection { post :import}
  end

  resources :disciplines
  get 'disciplines/import'
  resources :disciplines do
  	collection { post :import}
  end
  

  #put "teams/altpesqstatus", to: "teams#altpesqstatus"
  get 'teams/altpesqstatus/:id', to: 'teams#altpesqstatus', as: 'teams/altpesqstatus'
  resources :teams  
  get 'teams/import'
  resources :teams do
  	collection { post :import}
  end  
  
  resources :teamdiscs 
  get 'teamdiscs/import'
  resources :teamdiscs do
  	collection { post :import}
  end  
  
  resources :notefrequencies 
  get 'notefrequencies/import'
  resources :notefrequencies do
  	collection { post :import}
  end
  get  '/notefrequencies/indexstudent/:id', to: 'notefrequencies#indexstudent', as: 'notefrequencies/indexstudent'
  get  '/notefrequencies/showstudent/:id', to: 'notefrequencies#showstudent', as: 'notefrequencies/showstudent' 


  
  resources :registrations
  get 'registrations/import'
  resources :registrations do
  	collection { post :import}
  end   
  
  resources :users
  resources :accessplatforms 
  get 'welcome/index'
  #get 'welcome/index2'
=begin
devise_for :users, controllers:{
  sessions: 'users/sessions'
 } 
 
devise_scope :users do
  get 'signin', to: 'users/sessions#new'
  #get 'signout', to: 'users/registration#destroy'
end
  devise_for :users
  resources :accessplatforms
  get 'arquivos/index'
  
  
  #get 'registrations/index'
  
 
 
  
   
  
  
  #
  
  
root "welcome#index"
#root "registrations/index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'arquivos/index'
  post 'arquivos/upload_arquivo'
  post 'arquivos/download_arquivo'  
  
  
#If no route matches#
# match '*path', via: :all, to: redirect('/404') 
=end
end