class StarSign < ApplicationRecord
  has_many :horoscopes
  has_many :users
end
