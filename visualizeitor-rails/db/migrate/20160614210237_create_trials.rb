class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.integer :state
      t.references :teacher, index: true
      t.references :acform, index: true
      t.text :comment
      t.boolean :acctual

      t.timestamps null: false
    end
    add_foreign_key :trials, :teachers
    add_foreign_key :trials, :acforms
  end
end
