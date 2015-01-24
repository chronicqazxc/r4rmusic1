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
    # logger.debug "#{params}"
    # render plain: params['publisher']
    publisher_params = params['publisher']
    # render plain: publisher['id']
    publisher = Publisher.find(publisher_params['id'])
    publisher.update(name: publisher_params['name'], city: publisher_params['city'], country: publisher_params['country'])
    redirect_to :controller => "main", :action => "welcome"
  end
end
