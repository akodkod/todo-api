class UsersController < ApplicationController
  # Callbacks
  before_action :non_authentication_required!, only: [:create, :login]
  before_action :check_permissions, only: :update

  def index
    render json: users
  end

  def show
    render json: user
  end

  def create
    create_user = User.new

    if create_user.update(user_params)
      render json: create_user, status: :created
    else
      render_errors(create_user)
    end
  end

  def update
    if user.update(user_params)
      render json: user
    else
      render_errors(user)
    end
  end

  def login
    if login_user.present? && login_user.authenticate(params[:password])
      render json: { id: login_user.id, api_key: login_user.api_key }
    else
      render json: { status: 400 }, status: :bad_request
    end
  end

  private

  def user
    return @user if defined?(@user)
    @user = User.find(params[:id])
  end

  def users
    return @users if defined?(@users)
    @users = User.all
  end

  def login_user
    return @login_user if defined?(@login_user)
    @login_user = User.find_by(email: params[:email])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def check_permissions
    authentication_required!
    authorize! :update, user
  end
end
