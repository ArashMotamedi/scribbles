class Document < ActiveRecord::Base
  belongs_to :account
  has_many :comments
  has_many :logs
  has_many :file_tabs
  
  # Validation
  validates_presence_of :name, :account_id
  
  attr_protected :id, :salt
  attr_accessor :password
  
  def self.authenticate(docid, pw)
    doc = find(:first, :conditions => {:id => docid})
    if doc.nil?
      return nil
    end
    
    if Document.encrypt(pw, doc.salt) == doc.secure_password
      return doc
    end

    nil
  end
  
  def password=(pw)
    @password = pw
    if not self.salt?
      self.salt = Document.random_str(10)
    end
    
    self.secure_password = Document.encrypt(@password, self.salt)
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
