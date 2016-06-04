class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.string :state
      t.references :teacher, index: true
      t.references :acform, index: true
      t.text :comment

      t.timestamps null: false
    end
    add_foreign_key :evaluations, :teachers
    add_foreign_key :evaluations, :acforms
  end
end
