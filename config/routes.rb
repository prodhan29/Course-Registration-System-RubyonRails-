Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'appuser/index'

  get 'appuser/course_result'

  get 'appuser/publish_result'

  patch 'appuser/update'

  get 'appuser/edit_profile'

  get 'appuser/reg_details'

  get 'regdetails/edit_reg'

  post 'regdetails/update_reg'

  post 'appuser/submit_result'

  post 'appuser/get_past_result'

  post 'appuser/update_role'

  get 'appuser/allusers', :controller => "appuser", :action => 'get_all_users'

  post 'courses/semester_courses'

  resources :regdetails
  resources :courses
  resources :semesters

  root "appuser#index"
  post '/changecourse', :controller => 'regdetails', :action => 'change_courses'
  post '/regsubmit', :controller => 'regdetails', :action => 'reg_submission'
  get 'submission/details', :controller => 'regdetails', :action => 'show_registration_details'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
