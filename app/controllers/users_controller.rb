class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
    @motions = @user.motions.order(id: "DESC").first(10)
  end
end
