class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :term
      t.integer :found

      t.timestamps null: false
    end
  end
end
