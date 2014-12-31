class Work < ActiveRecord::Base
  belongs_to :composer
  has_and_belongs_to_many :editions, :order => "year ASC"
  has_and_belongs_to_many :instruments
end
