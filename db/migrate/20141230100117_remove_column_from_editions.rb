class RemoveColumnFromEditions < ActiveRecord::Migration
  def change
    remove_column :editions, :publisher, :string
  end
end
