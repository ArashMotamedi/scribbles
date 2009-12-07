class Document < ActiveRecord::Base
  belongs_to :account
  has_many :comments
  has_many :logs
  has_many :file_tabs
end
