class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :grr, :null => false, unique: true

      t.belongs_to :program
      t.belongs_to :major

      t.timestamps
    end
  end
end
