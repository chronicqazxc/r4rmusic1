class AddWorkRefToEditions < ActiveRecord::Migration
  def change
    add_reference :editions, :work, index: true
  end
end
