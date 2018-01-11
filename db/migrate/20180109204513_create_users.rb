class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.datetime :birthday
      t.integer :star_sign_id

      t.timestamps
    end
  end
end
