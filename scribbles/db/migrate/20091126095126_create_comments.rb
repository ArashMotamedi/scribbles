class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :author
      t.text :comment
	  t.integer :document_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
