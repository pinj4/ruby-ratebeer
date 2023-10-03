class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        ratings = self.ratings.map{ |r| r.score }
        (ratings.sum(0) / ratings.size).to_f
    end
end
