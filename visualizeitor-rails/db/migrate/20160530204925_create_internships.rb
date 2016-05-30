class CreateInternships < ActiveRecord::Migration
  def change
    create_table :internships do |t|
      t.date :start
      t.date :end
      t.integer :hours
      t.integer :assistType
      t.integer :internType
      t.references :student, index: true
      t.references :teacher, index: true
      t.references :contact, index: true

      t.timestamps null: false
    end
    add_foreign_key :internships, :students
    add_foreign_key :internships, :teachers
    add_foreign_key :internships, :contacts
  end
end
