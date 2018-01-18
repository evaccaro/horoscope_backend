class CreateStarSigns < ActiveRecord::Migration[5.1]
  def change
    create_table :star_signs do |t|
      t.string :sign
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
