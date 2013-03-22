class AddCreatorIdToInpsiration < ActiveRecord::Migration
  def change
    add_column :inspirations, :creator_id, :integer
  end
end
