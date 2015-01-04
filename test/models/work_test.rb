# require 'test_helper'
# 
# class WorkTest < ActiveSupport::TestCase
  # # test "the truth" do
  # #   assert true
  # # end
  # puts "yea it's my first test!"
# end


class WorkTest 
  PERIODS = {
    [1650..1750, %w{ EN DE FR IT ES NL }] => "Baroque",
    [1751..1810, %w{ EN IT DE NL }] => "Classical",
    [1751..1830, %w{ FR }] => "Classical",
    [1837..1901, %w{ EN }] => "Victorian",
    [1820..1897, %w{ DE FR }] => "Romantic"
  }
  
  def period(year, country)
    pkey = PERIODS.keys.find do |yrange, countries|
      yrange.include?(year) && countries.include?(country)
    end
    PERIODS[pkey] || "not found"
  end
end

work = WorkTest.new
puts work.period(1820, "DE")
