class CompletedSemester < ApplicationRecord
  belongs_to :user
  belongs_to :semester
end
