class UsersController < ApplicationController
  before_action :load_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to confirm_user_path(@user)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.confirmable(user_params[:confirmation_number])
      redirect_to confirmation_user_path(@user)
    else
      render :confirm
    end
  end

  def confirm
  end

  def confirmation
  end

  private

  def load_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:phone_number, :confirmation_number)
  end
end
