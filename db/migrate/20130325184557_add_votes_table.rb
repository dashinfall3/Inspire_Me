class AddVotesTable < ActiveRecord::Migration
  def change
  	create_table :votes do |t|
  		t.integer :photo_id, :null => false
  		t.integer :voter_id, :null => false
  	end
  	add_index :votes, [:voter_id, :photo_id], :unique => true
  end
end
