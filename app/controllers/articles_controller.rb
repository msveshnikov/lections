# encoding: utf-8
class ArticlesController < ApplicationController
  before_action :set_article

  def show
    render file: "/public/material/"+@article.id+".html"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
    #@parent = Category.find(@category.ParentCategory_ID) if @category.ParentCategory_ID != 0
    #add_breadcrumb 'МЕНЮ', :root_path
    #add_breadcrumb @parent.Title, @parent if @parent
  end
end
