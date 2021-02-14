class Movie < ActiveRecord::Base
    def self.all_ratings()
        # Get ratings that are present in movie list and return them
        # looked at https://blog.toshima.ru/2018/08/04/activerecord-distinct-pluck.html to learn how to extract all unique values of rating
        return Movie.distinct.pluck(:rating).sort
    end
    
    def self.with_ratings(ratings_list)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    # if ratings_list is nil, retrieve ALL movies
        if ratings_list.nil? or ratings_list.empty?
            return Movie.all
        end

        return Movie.where(rating: ratings_list)
    end
end
