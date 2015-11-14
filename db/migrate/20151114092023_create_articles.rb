class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles, { id: false } do |t|
      t.string :id
      t.string :parent
      t.string :title

      t.timestamps null: false
    end
  end
end
