class CreateJobSearches < ActiveRecord::Migration
  def up
    create_table :job_searches do |t|
      t.integer :user_id, :null => false
      t.string :search_term
      t.integer :zipcode

      t.timestamps
    end

    User.all.each{|u| u.send(:create_job_search)}
  end

  def down
    drop_table :job_searches
  end
end
