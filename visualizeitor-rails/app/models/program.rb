class Program < ActiveRecord::Base
  belongs_to :major
  has_many :program_items, :order => "column ASC, row ASC"
  has_many :students
end
