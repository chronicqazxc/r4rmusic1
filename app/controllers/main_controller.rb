class MainController < ApplicationController
  helper :composer, :work, :instrument
  def welcome
        
    logger.debug "logger test"
    
    @composers = Composer.all.sort_by {
      |c| [c.last_name, c.first_name, c.middle_name]
    }
    if (check_data(@composers) == false)
      welcome
    else
      return @composers
    end
    
    @periods = Work.all_periods
    @instruments = Instrument.all.order("name ASC")    
  end
  
  def show_period
    @period = params[:id]
    works = Work.all.select do |work|
      (work.period == @period) || (work.century == @period)
    end
    @editions = Edition.of_works(works)
  end
  
  def check_data(composers)
    if composers.size == 0
      MainController.init_data
      return false
    else
      return true
    end
  end
  
  def self.init_data
    add_composer("Johannes", "Brahms")
    add_composer("Claude", "Debussy")
    add_work(1,"Sonata for Cello and Piano in F Major")
    add_work(2,"String Quartet")
    add_edition(1, "Facsimile", "D. Black Music House", 1998, 21.95)
    add_edition(1, "Urtext", "RubyTunes, Inc.", 1977, 23.50)
    add_edition(1, "ed. Y.Matsumoto", "RubyTunes, Inc.", 2001, 22.95)
    add_edition(2, "", "D. Black Music House", 1995, 39.95)
    add_edition(2, "Reprint of 1894 ed.", "RubyTunes, Inc.", 2003, 35.95)
  end
  
  def self.add_composer(first_name, last_name)
    composer = Composer.new
    composer.first_name = first_name
    composer.last_name = last_name
    composer.save
  end
  
  def self.add_work(composer_id, title)
    work = Work.new
    work.composer_id = composer_id
    work.title = title
    work.save
  end
  
  def self.add_edition(work_id, description, publisher, year, price)
    edition = Edition.new
    # edition.work_id = work_id
    edition.description = description
    edition.publisher = publisher
    edition.year = year
    edition.price = price
    edition.save
  end
end
