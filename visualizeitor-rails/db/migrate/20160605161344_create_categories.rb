class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :descr
      t.integer :softlimit
      t.integer :hardlimit

      t.timestamps null: false
    end
  end
end
