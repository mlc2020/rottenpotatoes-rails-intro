class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @all_ratings = Movie.all_ratings
    
    returning_session = false
    
    if params[:sort]
      @sorting = params[:sort]
    elsif session[:sort]
      @sorting = session[:sort]
      returning_session = true
    end
    
    if params[:ratings]
      @sorting = params[:ratings]
    elsif session[:ratings]
      @sorting = session[:ratings]
      returning_session = true
    end
    
    if returning_session
      redirect_to movies_path(:sort => @sorting, :ratings => @ratings)
    end
    
    Movie.find(:all, :order => @sorting ? @sorting : :id).each do |ind_movie|
      if @ratings.keys.include?(ind_movie[:rating])
          @movies << ind_movie
      end
    end
    
    session[:sort] = @sorting
    session[:ratings] = @ratings
    
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
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
