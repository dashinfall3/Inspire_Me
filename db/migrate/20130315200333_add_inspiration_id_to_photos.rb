class AddInspirationIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :inspiration_id, :integer
  end
end
