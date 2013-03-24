class AddColumnstoUsersFacebook < ActiveRecord::Migration
  def change
  	add_column :users, :gender, :string
  	add_column :users, :location, :string
  end
end
