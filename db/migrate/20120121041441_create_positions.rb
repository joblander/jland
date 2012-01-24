class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.references :user
      t.references :lead_search
      t.string :source
      t.string :name
      t.text :details

      t.timestamps
    end
    add_index :positions, :user_id
    add_index :positions, :lead_search_id
  end
end
