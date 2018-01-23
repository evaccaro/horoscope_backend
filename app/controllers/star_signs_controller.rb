class StarSignsController < ApplicationController
  skip_before_action :authorized
  def index
    @star_signs = StarSign.all
    final = @star_signs.map do |star_sign|
      {
        info: star_sign,
        today: Horoscope.where("star_sign_id = ? AND day = ?", star_sign.id, Time.now.strftime("%m/%d/%Y")),
        historical: Horoscope.where("star_sign_id = ? AND NOT day = ?", star_sign.id, Time.now.strftime("%m/%d/%Y"))
      }
    end

    render json: final
  end

  def create
    @star_sign = StarSign.create(params)
    render json: StarSign.all
  end
end
