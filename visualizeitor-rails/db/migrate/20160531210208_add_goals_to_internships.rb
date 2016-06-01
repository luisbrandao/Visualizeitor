class AddGoalsToInternships < ActiveRecord::Migration
  def change
    add_column :internships, :goals, :text
  end
end
