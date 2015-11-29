class AddLowToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :low, :string
  end
end
