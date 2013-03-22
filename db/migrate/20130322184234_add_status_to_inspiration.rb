class AddStatusToInspiration < ActiveRecord::Migration
  def change
    add_column :inspirations, :status, :integer
  end
end
