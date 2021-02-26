class MotionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :show, :destroy]
  before_action :set_motion, only: [:edit, :update, :show, :destroy]
  before_action :move_to_index, except: [:new, :create]

  def new
    @motion = Motion.new
  end

  def create
    @motion = Motion.new(motion_params)
    if @motion.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @motion.update(motion_params)
      redirect_to motion_path(@motion)
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @motion.destroy
      redirect_to user_path(current_user.id)
    else
      render :show
    end
  end

  private
  def motion_params
    params.require(:motion).permit(:run, :abs, :squat, :push_ups, :spine).merge(user_id: current_user.id)
  end

  def set_motion
    @motion = Motion.find(params[:id])
  end

  def move_to_index
    unless @motion.user.id == current_user.id
      redirect_to root_path
    end
  end
end
