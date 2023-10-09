module RatingAverage
  extend ActiveSupport::Concern

  included do
    def average_rating
      ratings = self.ratings.map(&:score)
      (ratings.sum / ratings.size).to_f
    end
  end
end
