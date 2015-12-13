class RatingsController < ApplicationController

  def update
    @rating = Rating.create(article_id: params[:id], score: params[:score])
    render json: nil, status: :ok
  end

end