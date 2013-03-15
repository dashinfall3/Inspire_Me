class RenameNameToCaptionOnPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :name, :caption
  end
end
