class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :Name
      t.string :Password
      t.string :Email
      t.boolean :isPermenant

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
