class CreateAcforms < ActiveRecord::Migration
  def change
    create_table :acforms do |t|
      t.integer :state
      t.references :student, index: true

      t.timestamps null: false
    end
    add_foreign_key :acforms, :students
  end
end
