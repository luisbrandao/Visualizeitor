class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.date :start
      t.date :end
      t.integer :hours
      t.integer :hoursvalid
      t.references :acform, index: true

      t.timestamps null: false
    end
    add_foreign_key :activities, :acforms
  end
end
