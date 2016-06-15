class Category < ActiveRecord::Base
  validates :descr, :softlimit,:hardlimit, presence: true

  def to_s
    descr
  end
end
