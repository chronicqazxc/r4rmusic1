class Customer < ActiveRecord::Base
  has_many :orders, :dependent => true, :order => "created at ASC"
  
  # Which customers have ordered this work?
  def open_orders
    orders.find(:all, :conditions => "status = 'open'")
  end
  
  # What open orders does this customer have?
  def editions_on_order
    open_orders.map {|order| order.edition}.uniq
  end
  
  # What editions does this customer have on order?
  def edtion_history
    orders.map {|order| order.edition}.uniq
  end
  
  # What editions has this customer ever order?
  
  # What works does this customer have on order?
  def works_on_order
    edtions_on_order.map {|editon| edtion.works}.flatten.uniq
  end
  
  # What works has this customer ever ordered?
  def work_history
    edition_history.map {|editions| edition.works}.flatten.uniq
  end
  
  #Rankings per customer
  def rank(list)
    list.uniq.sort_by do |a|
      list.select {|b| a == b}.size
    end.reverse
  end
  
  def composer_rankings
    rank(edition_history.map {|ed| ed.composers}.flatten)
  end
  
  def instrument_rankings
    rank(work_history.map {|work| work.instruments}.flatten)
  end
  
  #Calculating the number of copies ordered
  def copies_of(edition)
    orders.find(:all, :conditions => "edition_id = #{edition.id}")
  end
  
  #Remaining unpaid balance
  def balance
    "%.2f" % open_orders.inject(0) do |acc, order|
      acc + order.edition.price
    end
  end
  
  #Customer check-out
  def check_out
    orders.each do |order|
      order.status = "paid"
      order.update
    end
  end
end
