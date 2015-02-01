class AddDetailsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :name, :string  	
  end
end
