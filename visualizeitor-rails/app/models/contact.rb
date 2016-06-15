class Contact < ActiveRecord::Base
belongs_to :company

  def to_s
    company.name + " |CNPJ: "+ company.cnpj + " |Contato: " + name
  end

  validates :name, :email, :qualification, :phone, :company_id, presence: true

end
