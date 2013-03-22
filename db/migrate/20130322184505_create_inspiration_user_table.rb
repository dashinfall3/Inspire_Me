class CreateInspirationUserTable < ActiveRecord::Migration
  def change
    create_table :inspiration_users do |t|
      t.integer :user_id, :null => false
      t.integer :inspiration_id, :null => false
      t.timestamps
    end
    add_index :inspiration_users, [:inspiration_id, :user_id], :unique => true
  end
  
end
