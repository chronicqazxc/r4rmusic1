# require 'test_helper'
# 
# class CustomerTest < ActiveSupport::TestCase
  # # test "the truth" do
  # #   assert true
  # # end
# end

class CustomerTest
  def rank(list)
    list.uniq.sort_by do |a|
      c = list.select { |b| a == b }
      p c
      c.size
    end.reverse
  end
  
  def composer_rankings
    rank(edition_history.map {|ed| ed.composers}.flatten)
  end
  
  def instrument_rankings
    rank(work_history.map {|work| work.instruments}.flatten)
  end
end

customer = CustomerTest.new
array = ["cello", "piano", "cello", "orchestra", "orchestra"]
array2 = customer.rank(array)
p array2
