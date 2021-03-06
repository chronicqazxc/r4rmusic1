class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "base"
  
  before_filter :get_customer
  
  def get_customer
    if session['customer']
      # render plain: session['customer']
      @c = Customer.find(session['customer'])
    end
  end
end
