class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  def create
    user = User.find_by(name: params[:name])

    if user && user.authenticate(params[:password])
      render json: {user: user, jwt: issue_token({id: user.id})}
    else
      render({json: {error: 'User is invalid'}, status: 401})
    end
  end

  def show
    if current_user
      render json: {
        user: current_user
      }
    else
      render json: {error: 'Invalid token'}, status: 401
    end
  end


end
