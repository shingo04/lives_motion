class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @tweets = Tweet.includes(:user).order(id: "DESC").first(10)
  end

  def new
    @tweet = Tweet.new
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
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :image).merge(user_id: current_user.id)
  end
end
