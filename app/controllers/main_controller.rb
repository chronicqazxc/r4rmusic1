class MainController < ApplicationController
  def welcome    
    @composers = Composer.all.sort_by {
      |c| [c.last_name, c.first_name]
    }
    # @composers = self.test_method(@composers)
  end
  
  def test_method(composers)
    composers.each do |composer|
      composer.first_name = "test la " + composer.first_name
    end
    return composers
  end
  
end
