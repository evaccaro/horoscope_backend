class HoroscopesController < ApplicationController
  def index
    @horoscopes = Horoscope.all
    render json: Horoscope.all
  end

  def create
    @horoscope = Horoscope.create(params)
    render json: Horoscope.all
  end
end
