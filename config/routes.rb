Rails.application.routes.draw do

  get 'appuser/index'

  get 'appuser/course_result'

  get 'appuser/publish_result'

  get 'appuser/update'

  get 'appuser/reg_details'

  post 'appuser/submit_result'

  resources :regdetails
  resources :courses
  resources :semesters
  devise_for :users
  root "appuser#index"
  post '/changecourse', :controller => 'regdetails', :action => 'change_courses'
  post '/regsubmit', :controller => 'regdetails', :action => 'reg_submission'
  get 'submission/details', :controller => 'regdetails', :action => 'show_registration_details'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
