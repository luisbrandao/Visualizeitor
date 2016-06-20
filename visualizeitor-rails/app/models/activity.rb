class Activity < ActiveRecord::Base
  has_many :acdocs, dependent: :destroy, autosave: true
  belongs_to :acform
  belongs_to :category


  accepts_nested_attributes_for :acdocs,
                                reject_if: proc { |attributes| attributes['descr'].blank?},
                                allow_destroy: true



  validates :hours, :acform_id, :category_id, presence: true

  def valid_hours
    if self.hours >= self.category.hardlimit
      return self.category.hardlimit
    else
      return self.hours
    end
  end
end
