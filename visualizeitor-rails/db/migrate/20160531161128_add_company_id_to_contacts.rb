class AddCompanyIdToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :company, index: true
    add_foreign_key :contacts, :companies
  end
end
