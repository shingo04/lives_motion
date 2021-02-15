class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @tweets = Tweet.includes(:user).order(id: "DESC").first(10)
    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end

  def new
    @tweet = Tweet.new
    @user = User.find(current_user.id)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(current_user.id)
    @tweet = Tweet.find(params[:id])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :image).merge(user_id: current_user.id)
  end
end
