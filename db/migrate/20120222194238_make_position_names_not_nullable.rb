class MakePositionNamesNotNullable < ActiveRecord::Migration
  class Position < ActiveRecord::Base; end
  def up
    Position.update_all(:name => '')
    change_column :positions, :name, :string, :null => false
  end

  def down
    change_column :positions, :name, :string, :null_allowed => true
  end
end
