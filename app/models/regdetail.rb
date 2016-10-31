class Regdetail < ApplicationRecord
  belongs_to :user
  belongs_to :semester
  validates_numericality_of :cgpa, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 4
   validates_uniqueness_of :user_id, scope: :course


  def self.save_registration params,current_user
    @course_list = params[:courses]
    @semester = Semester.find_by(name: params[:semester])
    @course_list.each {|h,k|

      # if(check_uniq_reg current_user, k[:id])
        reg = Regdetail.new(user: current_user, semester: @semester, course: k[:id], cgpa: 0.0)
        if reg.save!
          puts "----------save hoise ------------"
        end

        puts k[:id]
      # else
      #   puts "not unique"
      # end
    }
  end
  def check_uniq_reg user, course_id
     Regdetail.where(user: user, course: course_id).present?
  end
end
