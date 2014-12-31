class Edition < ActiveRecord::Base
  has_and_belongs_to_many :work
  belongs_to :publisher
  has_many :orders
end
