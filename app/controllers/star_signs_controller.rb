class StarSignsController < ApplicationController

  def index
    @star_signs = StarSign.all
    render json: StarSign.all
  end

  def create
    @star_sign = StarSign.create(params)
    render json: StarSign.all
  end
end
