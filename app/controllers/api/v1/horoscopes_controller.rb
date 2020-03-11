module Api
  module V1
    class HoroscopesController < ApplicationController
      skip_before_action :authorized

      def index
        @horoscopes = Horoscope.includes(:star_sign)
        render json: @horoscopes
      end

      def create
        @horoscope = Horoscope.create(params)
        render json: Horoscope.includes(:star_sign)
      end

      def showToday
        @horoscopes = Horoscope.includes(:star_sign).where("day = ?", Time.now.strftime("%m/%d/%Y"))
        render :json => @horoscopes
      end

      # def show
      #   @horoscopes = Horoscope.where("star_sign_id = ?", params[:id])
      #   render :json => @horoscopes
      # end

      def show
        @horoscopes = Horoscope.includes(:star_sign).where("star_sign_id = ? AND day = ?", params[:id], Time.now.strftime("%m/%d/%Y"))
        render :json => @horoscopes
      end
    end
  end
end
