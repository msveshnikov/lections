# encoding: utf-8
class ArticlesController < ApplicationController
  before_action :set_article
  before_action :check_for_mobile

  def show
    render file: "/public/material/"+@article.id+".html"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
    @parent = Category.find(@article.parent)
    add_breadcrumb 'МЕНЮ', :root_path
    add_breadcrumb @parent.title, @parent if @parent
  end
end
