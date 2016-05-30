class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :login, :null => false, unique: true
      t.integer :access, null: false, default: 0

      t.timestamps null: false
    end
  end
end
