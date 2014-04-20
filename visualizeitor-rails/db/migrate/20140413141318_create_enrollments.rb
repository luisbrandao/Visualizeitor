class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.decimal :grade
      t.decimal :frequency
      t.integer :year
      t.integer :semester
      t.string :status
      t.string :enrollment_type

      t.belongs_to :student
      t.belongs_to :course

      t.timestamps
    end
  end
end
