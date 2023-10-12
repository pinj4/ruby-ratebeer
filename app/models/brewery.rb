class Brewery < ApplicationRecord
  include RatingAverage

  validates :name, presence: true

  validate :year_cant_be_in_the_future, :year_cant_be_too_long_ago
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def year_cant_be_in_the_future
    if year > Date.today.year
      errors.add(:year, "can't be in the future")
    end
  end
  
  def year_cant_be_too_long_ago
    if year < 1040
      errors.add(:year, "can't be lower than 1040")
    end
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end
end
