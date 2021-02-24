class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_tweet, only: [:show, :destroy]
  before_action :move_to_index, only: [:destroy]

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
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def destroy
    if @tweet.destroy
      redirect_to user_path(current_user.id)
    else
      render :show
    end
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless @tweet.user.id == current_user.id
      redirect_to root_path
    end
  end
end
