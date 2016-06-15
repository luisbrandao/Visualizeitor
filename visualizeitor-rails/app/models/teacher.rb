class Teacher < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :authentication_keys => [:login]

  validates :name, :access, :email, presence: true
  validates :login, presence: true, uniqueness: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def to_s
    name
  end

  def access_txt
    ["Professor", "Comissão de avaliação de atividades formativas","Coordenação"][self.access]
  end
end

