class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :descr
      t.string :softlimit
      t.string :hardlimit
      t.reference :activity

      t.timestamps null: false
    end
  end
end
