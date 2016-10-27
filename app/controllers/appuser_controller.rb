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
    course_ids = Regdetail.where(:user_id => current_user.id).pluck(:course)
    result_list = Regdetail.where(:user_id => current_user.id).pluck(:cgpa)
    courses = Course.find(course_ids)
    credit_list = courses.collect { |c| c.credit }
    @total_credit = courses.inject(0) { |sum, c| sum+c.credit.to_d  }
    @cgpa =0
    credit_list.zip(result_list){|c,r| @cgpa+=(c.to_d * r.to_d)}
    @cgpa = @cgpa/@total_credit
    puts "------"
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
