class UsersController < ApplicationController

  def index

  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params)

    StarSign.all.each do |sign|
      if params[:birthday].strftime("%m/%d") >= sign.start_date.strftime("%m/%d") && params[:birthday].strftime("%m/%d") <= sign.end_date.strftime("%m/%d")
        @user.star_sign_id = sign.id
      end
    end
    if @user.save
      render json: @user
    end
  end

end
