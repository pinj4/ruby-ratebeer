module TopRated
  extend ActiveSupport::Concern

  class_methods do
    def top(number)
      sorted_by_rating_in_desc_order = all.sort_by(&:average_rating).reverse!
      sorted_by_rating_in_desc_order.first(number)
    end
  end
end
