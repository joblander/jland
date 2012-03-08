class CreateRelatedEmails < ActiveRecord::Migration
  def change
    create_table :related_emails do |t|

      t.timestamps
    end
  end
end
