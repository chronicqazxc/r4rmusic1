class Edition < ActiveRecord::Base
  has_and_belongs_to_many :works
  belongs_to :publisher
  
  #A nice title for the Edition model
  def nice_title
    (title || work[0].nice_title) + " (#{publisher.name}, #{year})"
  end

  #Determining all editions for a list of works
  def self.of_works(works)
    works.map {|work| work.editions}.flatten.uniq
  end
end
