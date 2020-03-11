class HoroscopeSerializer < ActiveModel::Serializer
  attributes :sign, :favorites, :content

  attribute :sign do
    object.star_sign.sign
  end

  attribute :favorites do
    object.favorites.size
  end
end
