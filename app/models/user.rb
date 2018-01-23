class User < ApplicationRecord
  has_secure_password
  has_many :horoscopes, through: :star_signs
  serialize :favorites, Array
end
