class CreateJobSearches < ActiveRecord::Migration
  def change
    create_table :job_searches do |t|
      t.integer :user_id
      t.string :search_term
      t.integer :zipcode

      t.timestamps
    end
  end
end
