class Category < ActiveRecord::Base

  def to_s
    descr
  end
end
