class Course < ActiveRecord::Base
  has_many :program_items

  has_many :enrollments
  has_many :students, through: :enrollments

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
