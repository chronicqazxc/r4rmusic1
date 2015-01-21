class ManageController < ApplicationController
  def main
    @publishers = Publisher.all
  end
  def publisher_params
    params.require(:publisher).permit(:name, :city, :country)
  end
  def add
    publisher = Publisher.new(publisher_params)
    publisher.save
    redirect_to :controller => "main", :action => "welcome"
  end
end
