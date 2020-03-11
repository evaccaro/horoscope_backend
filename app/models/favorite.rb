class Favorite < ApplicationRecord
    belongs_to :horoscope, counter_cache: true
end
