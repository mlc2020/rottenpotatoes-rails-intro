class Movie < ActiveRecord::Base
    def self.all_ratings
        allRatings = []
        Movie.all.each do |movie|
          if not allRatings.include?(movie.rating)
            allRatings << movie.rating
          end
        end
        
        allRatings.sort
    end
end
