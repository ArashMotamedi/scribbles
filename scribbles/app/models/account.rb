class Account < ActiveRecord::Base
  has_many :documents

  # Validation
  validates_presence_of :name
  validates_presence_of :expiration
  validates_inclusion_of :is_permanent, :in => [true, false]
  if :is_permanent == true
    validates_presence_of :password
    validates_presence_of :email
    validates_format_of :email, :with => /\A[\w\.]+@[\w\.]+\Z/, :message => "has invalid format"
  end
  
  validates_uniqueness_of :name
end
