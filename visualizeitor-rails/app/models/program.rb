class Program < ActiveRecord::Base
  belongs_to :major
  has_many :program_items
  has_many :students
end
