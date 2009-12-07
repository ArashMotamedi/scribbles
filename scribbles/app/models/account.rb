class Account < ActiveRecord::Base
  has_many :documents

  # Validation
  validates_presence_of :name
  validates_presence_of :is_permanent
  if :is_permanent
    validates_presence_of :password
    validates_presence_of :email
  end
  
  validates_uniqueness_of :name
  
  validates_format_of :email, :with => /\A[\w\.]+@[\w\.]+\Z/, :message => "has invalid format"
end
