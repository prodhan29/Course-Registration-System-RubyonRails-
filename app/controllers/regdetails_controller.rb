class RegdetailsController < ApplicationController
  before_action :set_regdetail, only: [:show, :edit, :update, :destroy]

  # GET /regdetails
  # GET /regdetails.json
  def index
    @regdetails = Regdetail.all
  end

  # GET /regdetails/1
  # GET /regdetails/1.json
  def show
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
      format.js{@courses}
    end
  end

  def reg_submission
    puts "---------new submission----------"
    @course_list = params[:courses]
    @semester = Semester.find_by(name: params[:semester])

    # @course_names = @courses.each{|h,k| puts k[:name]}
    # @course_ids = @course.each {|h,k| puts k[:id]}


    @course_list.each{|h,k| puts k[:name]}
    @course_list.each {|h,k|

      reg = Regdetail.new(user: current_user, semester: @semester, course: k[:id], cgpa: 0.0)
      reg.save!
      puts k[:id]
    }

    redirect_to controller:'regdetails', action: 'show_registration_details'

  end

  def show_registration_details

    puts "---------------------- current user registration details ------------------"
    @details = current_user.regdetails
    puts current_user.regdetails.inspect
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regdetail
      @regdetail = Regdetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regdetail_params
      params.require(:regdetail).permit(:user_id, :semester_id, :course, :cgpa)
    end
end
