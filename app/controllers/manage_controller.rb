require 'apns'
# require 'houston'

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

  def apns

    APNS.host = 'gateway.sandbox.push.apple.com' 
    # gateway.sandbox.push.apple.com is default

    APNS.pem  = 'cert.pem'
    # this is the file you just created
    
    APNS.port = 2195 
    # this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.

    device_token = '<143d27a0 abd66481 8fb03eda 3bac6bb0 0efcaee3 a5d19e65 c4118131 ca9d2111>'
    # device_token = '143d27a0abd664818fb03eda3bac6bb00efcaee3a5d19e65c4118131ca9d2111'
    # device_token = '0143d27a0abd664818fb03eda3bac6bb00efcaee3a5d19e65c4118131ca9d2111'
    push_params = params['apns']
    content = push_params[:content]
    # APNS.send_notification(device_token, content)
    APNS.send_notification(device_token, :alert => content, :badge => 5, :sound => 'default')

#Houston
# Environment variables are automatically read, or can be overridden by any specified options. You can also
# conveniently use `Houston::Client.development` or `Houston::Client.production`.
# apn = Houston::Client.development
# apn.certificate = File.read("cert.pem")

# # An example of the token sent back when a device registers for notifications
# token = "<5ab08f7f 26dec6f4 1afbcb18 a41e5cd9 4867a5c2 4f8c5a22 b1ffbd9b 22e0ccf6>"

# # Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
# notification = Houston::Notification.new(device: token)
# notification.alert = "Hello, World!"

# # Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
# notification.badge = 57
# notification.sound = "sosumi.aiff"
# notification.category = "INVITE_CATEGORY"
# notification.content_available = true
# notification.custom_data = {foo: "bar"}

# # And... sent! That's all it takes.
# apn.push(notification)    
  end
end
