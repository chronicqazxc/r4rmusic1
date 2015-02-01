# require 'apns'
require 'houston'
require 'net/http'

class ManageController < ApplicationController
  attr_accessor :pem_file, :is_pem_exist, :geocode

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

  def push_notification
    @is_pem_exist = File.exist?("#{Rails.root}/public/cert.pem")
  end

  def apns
    # reopen the class
    # APNS::Notification.class_eval do
    #   attr_accessor :category, :message_identifier, :content_available, :expiration_date, :priority

    #   def initialize(device_token, message)
    #     self.device_token = device_token
    #     if message.is_a?(Hash)
    #       self.alert = message[:alert]
    #       self.badge = message[:badge]
    #       self.sound = message[:sound]
    #       self.other = message[:other]
    #       self.category = message[:category]
    #       self.message_identifier = message[:message_identifier]
    #       self.content_available = !message[:content_available].nil?
    #       self.expiration_date = message[:expiration_date]
    #       self.priority = if self.content_available
    #         message[:priority] || 5
    #       else
    #         message[:priority] || 10
    #       end
    #     elsif message.is_a?(String)
    #       self.alert = message
    #     else
    #       raise "Notification needs to have either a hash or string"
    #     end

    #     self.message_identifier ||= OpenSSL::Random.random_bytes(4)
    #   end

    #   def packaged_message
    #     aps = {'aps'=> {} }
    #     aps['aps']['alert'] = self.alert if self.alert
    #     aps['aps']['badge'] = self.badge if self.badge
    #     aps['aps']['sound'] = self.sound if self.sound
    #     aps['aps']['category'] = self.category if self.category
    #     aps['aps']['content-available'] = 1 if self.content_available

    #     aps.merge!(self.other) if self.other
    #     aps.to_json
    #   end  
    # end

    # APNS.host = 'gateway.sandbox.push.apple.com' 
    # # gateway.sandbox.push.apple.com is default

    # APNS.pem  = 'cert.pem'
    # # this is the file you just created
    
    # APNS.port = 2195 
    # # this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.

    # device_token = '<143d27a0 abd66481 8fb03eda 3bac6bb0 0efcaee3 a5d19e65 c4118131 ca9d2111>'
    # # device_token = '143d27a0abd664818fb03eda3bac6bb00efcaee3a5d19e65c4118131ca9d2111'
    # # device_token = '0143d27a0abd664818fb03eda3bac6bb00efcaee3a5d19e65c4118131ca9d2111'
    # push_params = params['apns']
    # content = push_params[:content]
    # # APNS.send_notification(device_token, content)
    
    # APNS.send_notification(device_token, :alert => content, :badge => 5, :sound => 'default', :category => 'CATEGORY_ID')

    #Houston
    # Environment variables are automatically read, or can be overridden by any specified options. You can also
    # conveniently use `Houston::Client.development` or `Houston::Client.production`.
    apn = Houston::Client.development
    apn.certificate = File.read("#{Rails.root}/public/cert.pem")
    # apn.certificate = File.read("cert.pem")

    # An example of the token sent back when a device registers for notifications
    token = "<143d27a0 abd66481 8fb03eda 3bac6bb0 0efcaee3 a5d19e65 c4118131 ca9d2111>"

    # Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
    notification = Houston::Notification.new(device: token)

    push_params = params['apns']
    content = push_params[:content]

    notification.alert = content

    # Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
    notification.badge = 57
    notification.sound = "sosumi.aiff"
    notification.category = "CATEGORY_ID"
    notification.content_available = true
    notification.custom_data = {foo: "bar"}

    # And... sent! That's all it takes.
    apn.push(notification)    
    apn.certificate = File.delete("#{Rails.root}/public/cert.pem")
  end  

  def upload
    uploaded_io = params[:pem]
    File.open(Rails.root.join('public', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    @pem_file = uploaded_io.original_filename
    redirect_to :controller => "manage", :action => "push_notification"
  end

  # before_filter :whether_pem_exist
  
  # def whether_pem_exist
  #   @is_pem_exist = File.exist?("#{Rails.root}/public/cert.pem")
  # end  

  def transfor_address
    address = params[:transfor]
    address = address[:address]
    address = URI.escape("http://maps.google.com/maps/api/geocode/json?sensor=false&address=#{address}")
    address = Net::HTTP.get(URI.parse(address))    
    # @geocode = JSON.parse address
    # results = @geocode["results"]
    # geometry = results[0]["geometry"]
    # location = geometry["location"]
    # @geocode = location
    render plain: address
  end
end
