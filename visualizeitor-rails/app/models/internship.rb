class Internship < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher
  belongs_to :contact

  def internType_txt
    ["Obrigatório", "Não Obrigatório"][self.assistType]
  end

  def assistType_txt
    ["Direta", "Semi-direta", "Indireta"][self.internType]
  end
end
