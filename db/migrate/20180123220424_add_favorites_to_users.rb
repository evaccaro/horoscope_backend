class AddFavoritesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :favorites, :string
  end
end
