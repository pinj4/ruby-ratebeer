class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @recent_ratings = Rating.recent
    @top_breweries = Brewery.top 3
    @top_beers = Beer.top 3
    @top_styles = Style.top 3
    @active_users = User.active
  end

  def new
    expire_fragment('brewerylist')
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user
    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to current_user
  end
end
