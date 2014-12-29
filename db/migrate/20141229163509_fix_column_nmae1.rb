class FixColumnNmae1 < ActiveRecord::Migration
  def change
    rename_column :editions, :descriptioin, :description
  end
end
