class CustomerController < ApplicationController
  helper :composer, :work, :edition
  befor_filter :new_customer, :only => ["signup"]
  
  def new_customer
    applicant = params[:customer]
    if Customer.find_by_nick(applicant['nick'])
      report_error("Nick already in use. Please choose another")
    elsif Customer.find_by_email(applicant['email'])
      report_error("Account already exists for that email address.")
    end
  end
  
  def login
    session['customer'] = c.id
    redirect_to :controller => "main", :action => "welcome"
  end
  
  def signup
    c = Customer.new(params[:customer])
    c.password = Digest::SHA1.hexdigest(c.password)
    c.save
    session['customer'] = c.id
    redirect_to :controller => "main", :action => "welcome"
  end
  
  def view_cart
    
  end
  
  def add_to_cart
    e = Edition.find(params[:id])
    order = Order.create(:customer => @c,
                         :edition => e)
    if order
      redirect_to :action => "view_cart"
    else
      report_error("Trouble with saving order")
    end
  end
  
  def check_out
    @c.check_out
  end
end
