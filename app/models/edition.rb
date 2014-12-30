class Edition < ActiveRecord::Base
  belongs_to :work
  belongs_to :publisher
end
