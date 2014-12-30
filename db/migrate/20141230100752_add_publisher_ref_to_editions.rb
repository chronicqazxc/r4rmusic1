class AddPublisherRefToEditions < ActiveRecord::Migration
  def change
    add_reference :editions, :publisher, index: true
  end
end
