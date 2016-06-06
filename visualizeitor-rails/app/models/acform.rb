class Acform < ActiveRecord::Base
  belongs_to :student
  has_many :activities
end
