class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	symbolize :role,  :in => [:normal, :admin], :allow_blank => false, :methods => true, :scope => true
end
