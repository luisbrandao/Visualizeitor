class Internship < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher
  belongs_to :contact
end
