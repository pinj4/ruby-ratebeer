class Brewery < ApplicationRecord
  include RatingAverage
  include TopRated

  validates :name, presence: true

  validate :year_cant_be_in_the_future, :year_cant_be_too_long_ago
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil,false] }

  def year_cant_be_in_the_future
    return unless year > Date.today.year

    errors.add(:year, "can't be in the future")
  end

  def year_cant_be_too_long_ago
    return unless year < 1040

    errors.add(:year, "can't be lower than 1040")
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
