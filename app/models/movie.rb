class Movie < ActiveRecord::Base
    def self.all_ratings
        find_by_sql("SELECT DISTINCT rating FROM movies").map(&:rating)
    end
end
