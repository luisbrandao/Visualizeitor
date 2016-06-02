class Internship < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher
  belongs_to :contact

  def internType_txt
    if !self.internType.blank?
      ["Obrigatório", "Não Obrigatório"][self.internType]
    end
  end

  def assistType_txt
    if !self.assistType.blank?
      ["Direta", "Semi-direta", "Indireta"][self.assistType]
    end
  end
end
