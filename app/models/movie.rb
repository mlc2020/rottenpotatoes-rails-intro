class Movie < ActiveRecord::Base
    def self.all_ratings
        allRatings = []
        Movie.all.each do |movie|
          unless allRatings.include?(movie.rating)
            allRatings << movie.rating
          end
        end
        if allRatings.include?("NC-17")
          allRatings.sort!
          allRatings.delete("NC-17")
          allRatings << "NC-17"
          return allRatings
        else
          return allRatings.sort
        end
    end
end
