class CreateEditionsWorks < ActiveRecord::Migration
  def change
    create_table :editions_works, :id => false do |t|
      t.integer :edition_id
      t.integer :work_id
    end
  end
end
