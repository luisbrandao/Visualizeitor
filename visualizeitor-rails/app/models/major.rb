class Major < ActiveRecord::Base
  has_many :programs
  has_many :students
end
