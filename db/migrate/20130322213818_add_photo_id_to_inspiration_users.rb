class AddPhotoIdToInspirationUsers < ActiveRecord::Migration
  def change
    add_column :inspiration_users, :photo_id, :integer
  end
end
