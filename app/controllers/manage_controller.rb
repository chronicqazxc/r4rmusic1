class ManageController < ApplicationController
  def main
    @publishers = Publisher.all
  end
  def publisher_add_params
    params.require(:publisher).permit(:name, :city, :country)
  end
  def add
    publisher = Publisher.new(publisher_add_params)
    publisher.save
    redirect_to :controller => "main", :action => "welcome"
  end
  def publisher_edit_params
    params.require(:publisher).permit(:id, :name, :city, :country)
  end
  def edit
    logger.debug "#{params}"
    p = Publisher.find(id: 2)
    # publisher.update(name: publisher_edit_params[:publisher][:name], city: publisher_edit_params[:publisher][:city], country: publisher_edit_params[:publisher][:country])
    # redirect_to :controller => "main", :action => "welcome"
  end
end
