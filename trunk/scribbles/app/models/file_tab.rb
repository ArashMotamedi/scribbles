class FileTab < ActiveRecord::Base
  belongs_to :document
  
  # Validation
  validates_presence_of :name
  validates_presence_of :path
  validates_presence_of :document_id
end
