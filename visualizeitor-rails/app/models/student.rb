class Student < ActiveRecord::Base
  has_many :enrollments, -> { order('year ASC, semester ASC') }

  has_many :courses, through: :enrollments

  belongs_to :program
  belongs_to :major

end
