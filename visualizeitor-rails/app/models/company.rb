class Company < ActiveRecord::Base

  has_many :contacts, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :contacts,
                                reject_if: proc { |attributes| attributes['name'].blank?},
                                allow_destroy: true

  def to_s
    name
  end
end
