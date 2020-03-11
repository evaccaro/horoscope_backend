class Horoscope < ApplicationRecord
  belongs_to :star_sign
  has_many :favorites
end
