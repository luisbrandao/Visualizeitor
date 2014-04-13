class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.string :code
      t.integer :year

      t.belongs_to :major

      t.timestamps
    end
  end
end
