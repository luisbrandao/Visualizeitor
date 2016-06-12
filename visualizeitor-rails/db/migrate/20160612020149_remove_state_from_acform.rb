class RemoveStateFromAcform < ActiveRecord::Migration
  def change
    remove_column :acforms, :state
  end
end
