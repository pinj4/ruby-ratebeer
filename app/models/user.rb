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

  scope :active, -> { order(ratings_count: :desc).limit(3) }

  def to_s
    username.to_s
  end

  def ratings_count
    ratings.count
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_by(my_ratings, criteria)
    by_criteria = my_ratings
                  .group_by { |rating| rating.beer.send(criteria) }
                  .map { |key, val| [key, val.sum(&:score) / val.size] }

    by_criteria.max_by(&:last).first
  end

  def favorite_style
    return nil if ratings.empty?

    favorite_by(ratings, :style).name
  end

  def favorite_brewery
    return nil if ratings.empty?

    favorite_by(ratings, :brewery).name
  end
end
