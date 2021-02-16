class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.new(comment_params)
    @comments = @tweet.comments.includes(:user)
    if @comment.save
      redirect_to tweet_path(params[:tweet_id])
    else
      render 'tweets/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
