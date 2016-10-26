class AppuserController < ApplicationController

  before_action :authenticate_user!

  def index
    @registered = Regdetail.exists?(:user_id => current_user)
    puts "---------------------"
    puts
  end

  def course_result
    @user = User.find(params[:id])
  end

  def publish_result
  end

  def update
  end

  def reg_details
    @user =User.find(params[:id])
  end

  def submit_result
    @user = User.find(params[:id])
    @gpa_list = params[:cgpa_list]
    @user.regdetails.each_with_index { |r,index |
       r.cgpa =@gpa_list[index]
       puts r.cgpa.class
    }
    @user.regdetails.each(&:save)
  end
end
