class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :descr
      t.references :activity, index: true

      t.timestamps null: false
    end
    add_foreign_key :documents, :activities
  end
end
