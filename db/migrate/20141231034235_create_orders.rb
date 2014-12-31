class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :edition_id
      t.integer :customer_id
      t.string :status

      t.timestamps
    end
  end
end
