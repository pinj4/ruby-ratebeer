class Style < ApplicationRecord
  has_many :beers
  include RatingAverage
  include TopRated

  def average_rating
    beers.sum(&:average_rating)
  end
end
