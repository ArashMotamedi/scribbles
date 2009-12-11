class Comment < ActiveRecord::Base
  belongs_to :document

  # Validation
  validates_presence_of :author
  validates_presence_of :comment
end
