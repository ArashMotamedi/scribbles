class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string  :name
      t.text    :body
      t.integer :account_id
	  t.string  :lock_holder
      t.string  :password

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
