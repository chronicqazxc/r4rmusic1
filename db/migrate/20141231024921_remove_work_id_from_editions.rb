class RemoveWorkIdFromEditions < ActiveRecord::Migration
  def change
    remove_column :editions, :work_id, :integer
  end
end
