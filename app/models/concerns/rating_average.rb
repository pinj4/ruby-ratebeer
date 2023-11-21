module RatingAverage
  extend ActiveSupport::Concern

  included do
    def average_rating
      return 0 if self.ratings.empty?

      ratings = self.ratings.map(&:score)
      (ratings.sum / ratings.size).to_f
    end
  end
end
