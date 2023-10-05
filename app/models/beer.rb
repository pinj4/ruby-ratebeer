class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def average_rating
        ratings = self.ratings.map{ |r| r.score }
        (ratings.sum(0) / ratings.size).to_f
    end

    def to_s
        self.name + " " + self.brewery.name
    end
end
