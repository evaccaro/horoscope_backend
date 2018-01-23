class UsersController < ApplicationController
skip_before_action :authorized
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def new
    @user = User.new
  end

  def create
    user_birthday = DateTime.parse(user_params[:birthday])
    @user = User.new(user_params)

    capricorn = StarSign.find_by(sign: :capricorn)

    if user_birthday.strftime("%m/%d") < capricorn.end_date.strftime("%m/%d")
      @user.star_sign_id = capricorn.id
    else
      StarSign.all.each do |sign|
        if user_birthday.strftime("%m/%d") >= sign.start_date.strftime("%m/%d") && user_birthday.strftime("%m/%d") <= sign.end_date.strftime("%m/%d")
          @user.star_sign_id = sign.id
        end
      end
    end

    if @user.save
     render json: {user: @user, jwt: issue_token({id: @user.id})}
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(favorites: params[:favorites])
    @user.save
    redirect_to user_path(@user)
  end

  private
  def user_params
    params.permit(:name, :password, :birthday, :star_sign_id)
  end

end
