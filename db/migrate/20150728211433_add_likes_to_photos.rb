class AddLikesToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :likes, :integer, :default => 0
  end
end
