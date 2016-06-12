class AddAasmToAcform < ActiveRecord::Migration
  def change
    add_column :acforms, :aasm_state, :string
  end
end
