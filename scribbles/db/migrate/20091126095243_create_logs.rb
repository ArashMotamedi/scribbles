class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.text :description
	  t.integer :document_id

      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
