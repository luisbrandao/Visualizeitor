class Trial < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :acform

  accepts_nested_attributes_for :acform

  validates :state, :teacher_id, :acform_id, presence: true


  after_save :checa_estado
  def checa_estado
    self.acform.checa_estado
  end
  def state_txt
    ["Aprovado", "Recusado"][self.state]
  end
end
