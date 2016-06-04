class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :descr
      t.string :softlimit
      t.string :hardlimit
      t.references :activity, index: true

      t.timestamps null: false
    end
    add_foreign_key :categories, :activities
  end
end
