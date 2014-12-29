class AddDetailsToEditions < ActiveRecord::Migration
  def change
    add_column :editions, :descriptioin, :string
    add_column :editions, :publisher, :string
    add_column :editions, :year, :integer
    add_column :editions, :price, :float
  end
end
