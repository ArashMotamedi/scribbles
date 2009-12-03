class CreateFileTabs < ActiveRecord::Migration
  def self.up
    create_table :file_tabs do |t|
      t.string :Name
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :file_tabs
  end
end
