class AddDetailsToWorks2 < ActiveRecord::Migration
  def change
    add_column :works, :year, :integer
    add_column :works, :kee, :string
    add_column :works, :opus, :string
  end
end
