class CreateProgramItems < ActiveRecord::Migration
  def change
    create_table :program_items do |t|
      t.integer :row
      t.integer :column

      t.belongs_to :program

      t.belongs_to :course

      t.timestamps
    end
  end
end
