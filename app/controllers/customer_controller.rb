class CustomerController < ApplicationController
  helper :composer, :work, :edition
  before_filter :new_customer, :only => ["signup"]
  
  def new_customer
    applicant = params[:customer]
    if Customer.find_by_nick(applicant['nick'])
      report_error("Nick already in use. Please choose another")
    elsif Customer.find_by_email(applicant['email'])
      report_error("Account already exists for that email address.")
    end
  end
  
  def login
    applicant = params[:customer]
    # render plain: applicant[:nick].inspect
    c = Customer.find_by_nick(applicant[:nick])
    if c
      password = applicant[:password]
      password = Digest::SHA1.hexdigest(password)
      if c.password == password
        session['customer'] = c.id
        redirect_to :controller => "main", :action => "welcome"
      end
    else

    end
    
  end
  
  #http://stackoverflow.com/questions/17335329/activemodelforbiddenattributeserror-when-creating-new-user
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :nick, :password, :email)
  end
  def signup
    c = Customer.new(customer_params)
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
