class AddAssignmentToInternships < ActiveRecord::Migration
  def change
    add_column :internships, :assignment, :string
  end
end
