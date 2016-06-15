class Internship < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher
  belongs_to :contact

  validates :start, :end, :hours, :student_id, :contact_id, :assignment, presence: true
  validates :cnpj, presence: true, uniqueness: true

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
