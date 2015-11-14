# encoding: utf-8
class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :check_for_mobile

  # GET /categories
  def index
    @categories = Category.where('parent = "data2"')
  end

  # GET /categories/1
  def show
    @articles = @category.articles
    @categories = @category.categories
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
    @parent = Category.find(@category.parent) if @category.parent != "data2"
    add_breadcrumb 'МЕНЮ', :root_path
    add_breadcrumb @parent.title, @parent if @parent
  end
end


