class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :authentication_keys => [:grr]

  has_many :enrollments, -> { order('year ASC, semester ASC') }
  has_many :courses, through: :enrollments

  has_one :acform

  belongs_to :program
  belongs_to :major

  validates :name, presence: true
  validates :grr, presence: true, uniqueness: true

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
