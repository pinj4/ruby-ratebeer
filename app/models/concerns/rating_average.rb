module RatingAverage
    extend ActiveSupport::Concern

    included do
        def average_rating
            ratings = self.ratings.map{ |r| r.score }
            (ratings.sum(0) / ratings.size).to_f
        end
    end
end