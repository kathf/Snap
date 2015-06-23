class AddLikesToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :favourite, :boolean, default: false
  end
end
