class User < ApplicationRecord
  include RatingAverage

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
end
