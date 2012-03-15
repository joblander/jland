class AddMoreFieldsToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :city, :string

    add_column :positions, :state, :string

    add_column :positions, :country, :string

    add_column :positions, :post_date, :datetime

  end
end
