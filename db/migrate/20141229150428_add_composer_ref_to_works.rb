class AddComposerRefToWorks < ActiveRecord::Migration
  def change
    add_reference :works, :composer, index: true
  end
end
