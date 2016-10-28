class Regdetail < ApplicationRecord
  belongs_to :user
  belongs_to :semester
  accepts_nested_attributes_for :semester

  def self.save_registration params,current_user
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
  end
end
