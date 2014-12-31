class CreateInstrumentsWorks < ActiveRecord::Migration
  def change
    create_table :instruments_works, :id => false do |t|
      t.integer :instrument_id
      t.integer :work_id
    end
  end
end
