class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :authentication_keys => [:grr]

  has_many :enrollments, -> { order('year ASC, semester ASC') }

  has_many :courses, through: :enrollments

  belongs_to :program
  belongs_to :major

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def to_s
    name
  end
end
