class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :descr
      t.reference :activity

      t.timestamps null: false
    end
  end
end
