class Document < ActiveRecord::Base
  belongs_to :activity

  def to_s
    descr
  end
end
