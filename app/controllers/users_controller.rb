class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(id: "DESC")
    @motions = @user.motions.order(id: "DESC")
  end
end
