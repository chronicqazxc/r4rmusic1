class Work < ActiveRecord::Base
  belongs_to :composer
  has_and_belongs_to_many :editions, :order => "year ASC"
  has_and_belongs_to_many :instruments
  
  PERIODS = {
    [1650..1750, %w{ EN DE FR IT ES NL }] => "Baroque",
    [1751..1810, %w{ EN IT DE NL }] => "Classical",
    [1751..1830, %w{ FR }] => "Classical",
    [1837..1901, %w{ EN }] => "Victorian",
    [1820..1897, %w{ DE FR }] => "Romantic"
  }
  
  #Calculating a work’s period
  def period
    pkey = PERIODS.keys.find do |yrange, countries|
      yrange.include?(year) && countries.include?(country)
    end
    PERIODS[pkey] || century
  end
  
  #Teaching a work what its century is
  def century
    c = (year - 1).to_s[0, 2].succ
    c += case c
    when "21" then "st"
    else "th"
    end
    c + "century"
  end  
  
  # Which publishers have published editions of this work?
  def publishers
    editions.map {|e| e.publisher}.uniq
  end
  
  # What country is this work from?
  def country
    composer.country
  end
  
  # Which customers have ordered this work?
  def ordered_by
    editions.map {|e| e.orders}.flatten.map {|o| o.customer}.uniq
  end
  
  # What key is this work in?
  def key
    kee
  end
  
  #Formatting the names of the work’s instruments
  def nice_instruments
    instrs = instruments.map {|inst| inst.name}
    ordered = %w{flute oboe violin viola cello piano orchestra}
    instrs = instrs.sort_by {|i| ordered.index(i) || 0}
    
    case instrs.size
    when 0
      nil
    when 1
      instrs[0]
    when 2
      instrs.join(" and ")
    else
      instrs[0..-2].join(", ") + ", and " + instrs[-1]
    end
  end
  
  #Formatting a work’s opus number
  def nice_opus
    if /^\d/.match(opus)
      "op. #{opus}"
    else
      opus
    end
  end
  
  #The work’s prettified title
  def nice_title
    t, k, o, i = title, key, nice_opus, nice_instruments
    "#{t} #{"in #{k}" if k} #{", #{o}" if o} #{", for #{i} if i"}" 
  end
  
  #Determining all periods represented in the stock
  def self.all_periods
    find(:all).map {|c| c.period}.flatten.uniq.sort
  end
  
  #Determining sales rankings for works
  def self.sales_rankings
    r = Hash.new(0)
    find(:all).each do |work|
      work.editions.each do |ed|
        r[work.id] += ed.orders.size
      end
    end
    r
  end
  
end
