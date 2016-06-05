class Activity < ActiveRecord::Base
  has_many :documents, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :documents,
                                reject_if: proc { |attributes| attributes['descr'].blank?},
                                allow_destroy: true


  belongs_to :acform
  belongs_to :category


end
