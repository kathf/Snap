class AddViewsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :views, :integer, default: 0
  end
end
