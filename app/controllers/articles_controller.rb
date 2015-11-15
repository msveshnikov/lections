# encoding: utf-8
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update]
  before_action :check_for_mobile

  # GET /articles
  def index
    add_breadcrumb 'МЕНЮ', :root_path
    if params[:search]
      @articles = Article.search(params[:search])
      redirect_to article_path(@articles[0]) if @articles.size == 1
    else
      @recipes = Article.all
    end
  end

  # GET /article/id
  def show
    #render file: "/public/material/"+@article.id+".html"
  end

  def toggle
    s = cookies[:fav]
    s = '' if s.blank?
    f = s.split(',')
    if f.include? params[:id]
      f.delete params[:id]
      render text: 'heart-off.jpg'
    else
      f << params[:id]
      render text: 'heart-on.jpg'
    end
    cookies.permanent[:fav] = f.join(',')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
    @parent = Category.find(@article.parent)
    @megaparent = Category.find(@parent.parent) if @parent and @parent.parent != "data2"
    add_breadcrumb 'МЕНЮ', :root_path
    add_breadcrumb @megaparent.title, @megaparent if @megaparent
    add_breadcrumb @parent.title, @parent if @parent
    add_breadcrumb @article.title, @article
  end
end
