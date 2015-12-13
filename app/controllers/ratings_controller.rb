class RatingsController < ApplicationController

  def update
    @rating = Rating.create(article_id: params[:id], score: params[:score])
    render json: nil, status: :ok
  end

  # GET /ratings/1
  def show
    redirect_to Rating.find(params[:id]).article
  end

end