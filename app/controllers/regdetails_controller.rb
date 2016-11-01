require 'will_paginate/array'

class RegdetailsController < ApplicationController
  before_action :set_regdetail, only: [:show, :destroy]

  # GET /regdetails
  # GET /regdetails.json
  def index
    @regdetails = Regdetail.select(:user_id).distinct
    @user_ids = @regdetails.collect { |r| r.user_id }
    @registered_users = User.find(@user_ids).paginate(:page => params[:page], :per_page => 5)
    # @registered_users = @registered_users.paginate(:page => params[:page], :per_page => 4)

  end

  # GET /regdetails/1
  # GET /regdetails/1.json
  def show
  end

  def edit_reg
    @all_semester = Semester.all
    @semester_names = @all_semester.collect{|s| s.name}
    @courses = @all_semester[0].courses
    @current_semester = Regdetail.find_by(user: current_user).semester
    course_ids = Regdetail.where(user_id: current_user.id).pluck(:course)
    @taken_courses = Course.find(course_ids)

    # ---------------- setting active semester and courses----------
    semester_index= @semester_names.index(@current_semester.name)
    @courses = @all_semester[semester_index].courses
    @semester_names.delete(@current_semester.name)
    @semester_names.unshift(@current_semester.name)

  end

  def update_reg
    Regdetail.where(user: current_user).destroy_all

    Regdetail.save_registration params, current_user
    course_ids = Regdetail.where(user_id: current_user.id).pluck(:course)
    @courses = Course.find(course_ids)
    respond_to do |format|
      format.js{}
    end
  end

  # GET /regdetails/new
  def new
    @all_semester = Semester.all
    @semester_names = @all_semester.collect{|s| s.name}
    @courses = @all_semester[0].courses
  end


  # DELETE /regdetails/1
  # DELETE /regdetails/1.json
  def destroy
    @regdetail.destroy
    respond_to do |format|
      format.html { redirect_to regdetails_url, notice: 'Regdetail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_courses

    @sem = Semester.find_by(name: params[:semester])
    @courses = @sem.courses
    respond_to do |format|
      format.js{}
    end
  end

  def reg_submission
    semester = Semester.find_by(name: params[:semester])
    cs = CompletedSemester.new(user: current_user, semester: semester,cgpa: "0")
    cs.save!

    Regdetail.save_registration params, current_user
    redirect_to controller:'regdetails', action: 'show_registration_details'
  end

  def show_registration_details
    semester = get_current_semester current_user
    @details = Regdetail.where(user: current_user, semester: semester)
    course_ids = Regdetail.where(:user => current_user, :semester => semester).pluck(:course)
    courses = Course.find(course_ids)
    @total_credit = courses.inject(0) { |sum, c| sum+c.credit.to_d  }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regdetail
      @regdetail = Regdetail.find(params[:id])
    end

  def get_current_semester(user)
    cs = CompletedSemester.where(user: user).last(1)
    begin
      cs[0].semester
    rescue Exception => e
    end

  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regdetail_params
      params.require(:regdetail).permit(:user_id, :semester_id, :course, :cgpa)
    end
end
