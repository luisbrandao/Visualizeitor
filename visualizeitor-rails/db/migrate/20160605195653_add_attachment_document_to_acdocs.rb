class AddAttachmentDocumentToAcdocs < ActiveRecord::Migration
  def self.up
    change_table :acdocs do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :acdocs, :document
  end
end
