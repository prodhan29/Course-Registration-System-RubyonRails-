module RegdetailsHelper

  def get_course_name id
    @course = Course.find(id)
    @course.name
  end
end
