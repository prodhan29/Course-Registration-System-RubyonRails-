class AppuserController < ApplicationController

  before_action :authenticate_user!

  def index
    @registered = Regdetail.exists?(:user_id => current_user)
    if current_user.admin
      @semester_info = Hash.new
      @user_types = User.group(:admin).count
      @new_students = User.where(:admin=>false).last(5).reverse
      semesters = Semester.all
      semesters.each do |s|
        @semester_info[s.name] = s.courses.count
      end
    else
      @current_semester = get_current_semester current_user
      @previous_semester = get_previous_semester current_user

      @current_subjects = Regdetail.where(user: current_user, semester: @current_semester).count
      @current_cgpa,@current_credit = credits_and_cgpa @current_semester

      @previous_cgpa, @previous_credit = credits_and_cgpa @previous_semester
      @previous_subjects = Regdetail.where(user: current_user, semester: @previous_semester).count

    end
  end

  def get_all_users
    @all_users = User.paginate(:page => params[:page], :per_page => 4)
  end

  def course_result
    @user =User.find(params[:id])
    semester = get_current_semester @user
    @regdetails = Regdetail.where(user: @user, semester:  semester)
  end

  # to show current-user's his result
  def publish_result

    semester = get_current_semester current_user
    @regdetails = Regdetail.where(user: current_user, semester:  semester)
    @cgpa, @total_credit = credits_and_cgpa semester
  end

  def update
    @user = User.find(current_user.id);
    @user.update(user_params)
    respond_to do |format|
      format.js
    end
  end

  def reg_details
    @user =User.find(params[:id])
    semester = get_current_semester @user
    @regdetails = Regdetail.where(user: @user, semester:  semester)
  end

  def submit_result
    @user = User.find(params[:id])
    @gpa_list = params[:cgpa_list]
    semester = get_current_semester @user
    @regdetails = Regdetail.where(user: @user, semester: semester)
    @regdetails.each_with_index { |r,index |
       r.cgpa =@gpa_list[index]
    }
    @regdetails.each(&:save)
    CourseSystemMailer.publish_result(@user.email).deliver
    respond_to do|format|
      format.js {}
    end
  end

  def update_role
    @user = User.find(params[:id])
    @user.admin = params[:role]
    @user.save!
    @all_users = User.all
    respond_to do |format|
      format.js
    end
  end


end

private
  def user_params
    params.require(:user).permit(:name, :password)
  end

  def get_current_semester(user)
    cs = CompletedSemester.where(user: user).last(1)
    begin
    cs[0].semester
    rescue Exception => e
    end

  end

  def get_previous_semester user
    cs = CompletedSemester.where(user: user).last(2)
    begin
      cs[0].semester
    rescue Exception => e
    end
  end

  def credits_and_cgpa sem
    course_ids = Regdetail.where(:user => current_user, :semester =>sem ).pluck(:course)
    result_list = Regdetail.where(:user => current_user, :semester => sem).pluck(:cgpa)
    courses = Course.find(course_ids)
    credit_list = courses.collect { |c| c.credit }
    total_credit = courses.inject(0) { |sum, c| sum+c.credit.to_d  }
    cgpa =0
    credit_list.zip(result_list){|c,r| cgpa+=(c.to_d * r.to_d)}
    begin
      cgpa = cgpa/total_credit
    rescue Exception => e
    end

    return cgpa, total_credit
  end