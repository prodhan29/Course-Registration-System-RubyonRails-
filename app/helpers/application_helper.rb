module ApplicationHelper

  def get_user_type user
    if user.admin then "Admin" else "Student"
    end
  end

  def get_course_name id
    @course = Course.find(id)
    @course.name
  end

  def get_course_code id
    @course = Course.find(id)
    @course.code
  end

  def get_course_credit id
    Course.find(id).credit
  end


end
