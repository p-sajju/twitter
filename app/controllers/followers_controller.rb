class FollowersController < ApplicationController
  before_action :authenticate_user!
  
  def follow
    if params[:following_id].blank?
      render json: {success: false, code: "404", message: 'User required to follow'}
      return
    end
    following_user = User.find_by_id(params[:following_id])
    if following_user.blank?
      render json: {success: true, code: "200", message: 'A vaild user to follow'}
      return
    end
    follow = Follow.where(user_id: current_user.id, following_id: params[:following_id])
    if follow.blank?
      Follow.create(user_id: current_user.id, following_id: params[:following_id])
      render json: {success: true, code: "200", message: "You are following the user successfully"}
    else
      render json: {success: true, code: "200", message: 'Already following.'}
      return
    end
  end

  def unfollow
    if params[:unfollow_id].blank?
      render json: {success: false, code: "404", message: 'User required to un follow!'}
      return
    end
    user = User.find_by_id(params[:unfollow_id])
    if user.blank?
      render json: {success: false, code: "404", message: 'Please proivde valid user to Unfollow'}
      return
    end
    follow = Follow.where(user_id: current_user.id, following_id: params[:unfollow_id])
    if follow.blank?
      render json: {success: false, code: "404", message: "You do not follow this user"}
    else
      follow.destroy_all
      render json: {success: true, code: "200", message: 'Sucessfully Unfollowed.'}
      return
    end
  end
end