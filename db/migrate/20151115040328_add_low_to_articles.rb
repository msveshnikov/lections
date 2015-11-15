class AddLowToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :low, :string
  end
end
