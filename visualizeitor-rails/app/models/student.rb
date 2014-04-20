class Student < ActiveRecord::Base
  has_many :enrollments
  has_many :courses, through: :enrollments

  belongs_to :program
  belongs_to :major

end
