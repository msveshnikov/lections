class SearchesController < ApplicationController

  def show
    redirect_to articles_url + "?utf8=✓&search=" + Search.find(params[:id]).term
  end

end