class AddFavoritesCountToHoroscopes < ActiveRecord::Migration[5.1]
  def change
    add_column :horoscopes, :favorites_count, :integer
  end
end
