module Admin::AiringsHelper
  def first_year
    Airing.first(:order => "date ASC").date.year
  end
  
  def last_year
    Airing.last(:order => "date ASC").date.year
  end
end
