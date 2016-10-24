Rails.application.routes.draw do
  resources :regdetails
  resources :courses
  resources :semesters
  devise_for :users
  root "semesters#index"
  post '/changecourse', :controller => 'regdetails', :action => 'change_courses'
  post '/regsubmit', :controller => 'regdetails', :action => 'reg_submission'
  get 'submission/details', :controller => 'regdetails', :action => 'show_registration_details'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
