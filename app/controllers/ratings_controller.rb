class RatingsController < ApplicationController

  def update
    @rating = Rating.find(params[:id])
    @rating.update_attributes(score: params[:score])
  end

end