class PlacesController < ApplicationController
  before_action :set_place, only: %i[show]

  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_city] = params[:city]
      render :index, status: 418
    end
  end

  def show
  end

  def set_place
    @places = BeermappingApi.places_in(session[:last_city])
    @place = @places.find{ |place| place['id'] == params[:id] }

  end
end
