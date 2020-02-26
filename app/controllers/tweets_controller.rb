class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    followers_ids = Follow.where(user_id: current_user.id).pluck(:following_id)
    if params[:tweet][:order] == 'desc'
      @tweets = Tweet.where(user_id: followers_ids).order("created_at DESC")
    else
      @tweets = Tweet.where(user_id: followers_ids).order("created_at ASC")
    end
  end

  def create
    if params[:tweet][:message].blank?
      render json: {success: false, code: 400, message: 'Please proivde valid parameters'}
      return
    end
    tweet = current_user.tweets.create(message: params[:tweet][:message])
    render json: { success: true, code: '200', message: "You have successfully tweet!", data: tweet }
  end
end