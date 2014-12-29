class AddDetailsToWorks < ActiveRecord::Migration
  def change
    add_column :works, :title, :string
  end
end
