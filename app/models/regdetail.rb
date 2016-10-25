class Regdetail < ApplicationRecord
  belongs_to :user
  belongs_to :semester
  accepts_nested_attributes_for :semester
end
