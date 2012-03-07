class AddFieldsToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :company, :string

    add_column :positions, :comments, :text

    add_column :positions, :app_link, :text

    add_column :positions, :app_due_date, :datetime

  end
end
