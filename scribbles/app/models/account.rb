require 'digest/sha1'

class Account < ActiveRecord::Base
  has_many :documents

  # Validation
  validates_presence_of :name, :expiration
  validates_format_of :name, :with => /^[\w\d_]+$/, :message => "can only be alphanumeric and no spaces"
  validates_inclusion_of :is_permanent, :in => [true, false]
  
  # Only do this validation if it's a permanent account
  validates_presence_of :password, :password_confirmation, :salt, :email, :if => :is_permanent?
  validates_length_of :password, :within => 5..30, :if => :is_permanent?
  validates_format_of :email, :with => /\A[\w\.]+@[\w\.]+\Z/, :message => "has invalid format", :if => :is_permanent?
  validates_confirmation_of :password, :if => :is_permanent?
  # End permanent account validation
  
  validates_uniqueness_of :name
  
  attr_protected :id, :salt
  attr_accessor :password, :password_confirmation
  
  def self.authenticate(username, pw)
    acc = find(:first, :conditions => {:name => username})
    if acc.nil?
      return nil
    end
    
    if Account.encrypt(pw, acc.salt) == acc.secure_password
      return acc
    end

    nil
  end
  
  def password=(pw)
    @password = pw
    if not self.salt?
      self.salt = Account.random_str(10)
    end
    
    self.secure_password = Account.encrypt(@password, self.salt)
  end
  
  #### Protected methods ####
  protected
  
  def self.encrypt(pw, salt)
    Digest::SHA1.hexdigest(pw + salt)
  end
  
  def self.random_str(length)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    rnd = ""
    1.upto(length) do |i|
      rnd << chars[rand(chars.size-1)]
    end
    rnd
  end
  
end
