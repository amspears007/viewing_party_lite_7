# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def show 
    @user = User.find(params[:id])
    @viewing_parties_hosting = @user.viewing_parties
  end

  def new; end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to "/users/#{user.id}"
      flash[:notice] = "User successfully registered."
    else
      redirect_to "/register"
      flash[:alert] = "Error: #{error_message(user.errors)}"
    end
  end

  def discover
    
  end

  private 
  def user_params
    params.permit(:name, :email)
  end
end
