class AddStatusToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :pstatus, :string, :null => false, :default => 'to_apply'
  end
end
