class Customer < ActiveRecord::Base
  has_many :orders, :dependent => true, :order => "created at ASC"
end
