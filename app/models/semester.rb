class Semester < ApplicationRecord
  has_many :courses
  has_many :completed_semesters
end
