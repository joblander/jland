class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false, :unique => true
      t.string :password_digest
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    add_index :users, :email, :unique => true
  end
end