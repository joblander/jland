class CreateRelatedEmails < ActiveRecord::Migration
  def change
    create_table :related_emails do |t|
      t.string :guid, :null => false
      t.integer :position_id, :null => false, :dependent => :destroy
      t.timestamps
    end
  end
end
