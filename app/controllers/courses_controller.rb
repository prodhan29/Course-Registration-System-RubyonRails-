class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]


  def index
    @courses = Course.all
    @semesters = Hash.new
    @semesters["All"]=0
    Semester.all.each do|s|
      @semesters[s.name] = s.id
    end
  end


  def show
  end

  def new
    @course = Course.new
    @semesters = Semester.pluck(:name)
    puts @semesters.inspect
  end

  def edit
    @semesters = Semester.all
    @semesters = @semesters.collect{|s| s.name}
  end

  def create
    @course = Course.new(course_params)
    @sem  = Semester.find_by(name: params[:semester])
    @course.semester =@sem
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def semester_courses

    puts params[:id].class
    @courses = (params[:id] == "0")?Course.all : Semester.find(params[:id]).courses

    respond_to do |format|
      format.js{}
    end
  end


  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :code, :semester_id, :credit)
    end
end
