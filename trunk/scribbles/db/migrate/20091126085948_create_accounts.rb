class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :secure_password
      t.string :salt
      t.string :email
      t.integer :expiration  # -1 means no expiration
      t.boolean :is_permanent

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
