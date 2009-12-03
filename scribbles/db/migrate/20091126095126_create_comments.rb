class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :Author
      t.text :Comment

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
