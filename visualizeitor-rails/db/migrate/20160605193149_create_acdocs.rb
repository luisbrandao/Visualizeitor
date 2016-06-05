class CreateAcdocs < ActiveRecord::Migration
  def change
    create_table :acdocs do |t|
      t.string :descr
      t.references :activity, index: true

      t.timestamps null: false
    end
    add_foreign_key :acdocs, :activities
  end
end
