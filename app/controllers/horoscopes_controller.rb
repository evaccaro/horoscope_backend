class HoroscopesController < ApplicationController
  skip_before_action :authorized

  def index
    @horoscopes = Horoscope.all
    render json: Horoscope.all
  end

  def create
    @horoscope = Horoscope.create(params)
    render json: Horoscope.all
  end

  def showToday
    @horoscopes = Horoscope.where("day = ?", Time.now.strftime("%m/%d/%Y"))
    render :json => @horoscopes
  end

  def aries
    @horoscopes = Horoscope.where("star_sign_id = ?", 1)
    render :json => @horoscopes
  end

end
