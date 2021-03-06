class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # Session
    # Only have this path when you first enter the index page
    # Otherwise, it is /movies when you go back to index
    if request.path == '/'
      reset_session
    end
    
    # "Remember"/refill form inputs using session
    @ratings_to_show = !session[:ratings_to_show].nil? ? session[:ratings_to_show] : []

    if !session[:sort_by].nil?
      # if the sort by value changed, account for that
      if !params[:sort].nil? and params[:sort] != session[:sort_by]
        session[:sort_by] = params[:sort]
      end
      @sort = session[:sort_by]
    else
      @sort = params[:sort] 
    end
    
    # Set session values
    session[:sort_by] = @sort
    
    if !params[:ratings].nil?
      @ratings_to_show = params[:ratings].keys
      session[:ratings_to_show] = @ratings_to_show
    end
    
    # Define what will be shown in the view
    @movies = Movie.with_ratings(@ratings_to_show)
    @all_ratings = Movie.all_ratings


    # bg-warning is the Bootstrap class
    # hilite is a CSS class that sets the color back to normal if we aren't sorting by it
    if @sort
      @movies = @movies.order(@sort) 
        case @sort
        when "title"
          @title_header = 'bg-warning'
        when !"title"
          @title_header = 'hilite'
        when "release_date"
          @release_date_header = 'bg-warning'
        when !"release_date"
          @release_date_header = 'hilite'
        end
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end
