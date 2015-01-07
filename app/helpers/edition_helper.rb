module EditionHelper
  def link_to_edition(edition)
    link_to(edition.description,
            :controller => "edition",
            :action => "show",
            :id => edition.id)
  end
  
  def link_to_edition_title(edition)
    link_to(edition.nice_title,
            :controller => "edition",
            :action => "show",
            :id => edition.id)
  end
end
