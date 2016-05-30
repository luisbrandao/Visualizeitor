class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.string :activity

      t.timestamps null: false
    end
  end
end
