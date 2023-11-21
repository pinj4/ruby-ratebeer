module TopRated
    extend ActiveSupport::Concern
  
class_methods do
    def top(n)
      sorted_by_rating_in_desc_order = self.all.sort_by{ |b| b.average_rating }.reverse!
      return sorted_by_rating_in_desc_order.first(n)
    end
  end
end
