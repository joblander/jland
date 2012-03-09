class AddStarredToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :starred, :boolean, :null => false, :default => false
  end
end
