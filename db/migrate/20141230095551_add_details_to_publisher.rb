class AddDetailsToPublisher < ActiveRecord::Migration
  def change
    add_column :publishers, :name, :string
    add_column :publishers, :city, :string
    add_column :publishers, :country, :string
  end
end
