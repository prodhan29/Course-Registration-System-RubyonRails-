class Regdetail < ApplicationRecord
  belongs_to :user
  belongs_to :semester
  validates_numericality_of :cgpa, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 4
  validates_uniqueness_of :user_id, scope: :course


  def self.save_registration params,current_user
    @course_list = params[:courses]
    @semester = Semester.find_by(name: params[:semester])
    @course_list.each {|h,k|

        reg = Regdetail.new(user: current_user, semester: @semester, course: k[:id], cgpa: 0.0)
        reg.save!
    }

  end
end
