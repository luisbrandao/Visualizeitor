class Acdoc < ActiveRecord::Base
  belongs_to :activity
  has_attached_file :document

  validates_attachment :document,
                       :presence => true,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf"] }

  def to_s
    descr
  end
end
