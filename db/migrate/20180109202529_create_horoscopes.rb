class CreateHoroscopes < ActiveRecord::Migration[5.1]
  def change
    create_table :horoscopes do |t|
      t.string :day
      t.text :content
      t.string :origin
      t.integer :star_sign_id

      t.timestamps
    end
  end
end
