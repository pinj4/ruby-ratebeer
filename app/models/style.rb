class Style < ApplicationRecord
  has_many :beers
  include RatingAverage
  include TopRated

  def average_rating
    total = self.beers.sum{|b| b.average_rating }
    total
  end

  
end
