class Account < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :password
  validates_presence_of :email
  validates_presence_of :is_permanent
  
  validates_uniqueness_of :name
  
  validates_format_of :email, :with => /\A[\w\.]+@[\w\.]+\Z/, :message => "has invalid format"
end
