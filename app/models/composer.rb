class Composer < ActiveRecord::Base
  has_many :works
  
  # What editions of this composer's works exist?
  def editions
    works.map {|work| work.editions}.flatten.map
  end
  
  # What publishers have editions of this composer's works?
  def publishers
    editions.map {|edition| edition.publisher}.uniq
  end
  
  #Determining sales rankings for composers
  def self.sales_rankings
    r = Hash.new(0)
    Work.sales_rankings.map do |work, sales|
      r[work.composer.id] += sales
    end
    r
  end
end
