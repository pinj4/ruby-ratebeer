class User < ApplicationRecord
  include RatingAverage
  include Enumerable

  has_secure_password

  validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*[A-Z])(?=.*[0-9]).{3,}/ }

  validates :username, uniqueness: true,
                       length: { in: 3..30 }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, -> { distinct }, through: :memberships

  def to_s
    username.to_s
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def styles_points
    points = {}

    ratings.each do |r|
      points[r.beer.style] = 0 if points[r.beer.style].nil?
      points[r.beer.style] += r.score
    end
    points
  end

  def styles_count
    count = {}

    ratings.each do |r|
      count[r.beer.style] = 0 if count[r.beer.style].nil?
      count[r.beer.style] += 1
    end
    count
  end

  def styles_average
    hash = {}

    styles_points.each do |name, sum|
      avg = sum / styles_count[name]
      hash[name] = avg
    end
    hash
  end

  def favorite_style
    return nil if ratings.empty?

    styles_average.max_by(&:last).first.name
  end

  def breweries_points
    points = {}

    ratings.each do |r|
      points[r.beer.brewery] = 0 if points[r.beer.brewery].nil?
      points[r.beer.brewery] += r.score
    end
    points
  end

  def breweries_count
    count = {}

    ratings.each do |r|
      count[r.beer.brewery] = 0 if count[r.beer.brewery].nil?
      count[r.beer.brewery] += 1
    end
    count
  end

  def breweries_average
    hash = {}

    breweries_points.each do |name, sum|
      avg = sum / breweries_count[name]
      hash[name] = avg
    end
    hash
  end

  def favorite_brewery
    return nil if ratings.empty?

    breweries_average.max_by(&:last).first.name
  end
end
