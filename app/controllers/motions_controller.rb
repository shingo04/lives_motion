class MotionsController < ApplicationController
  def new
    @motion = Motion.new
    @user = User.find(current_user.id)
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
    @user = User.find(current_user.id)
    @motion = Motion.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    @motion = Motion.find(params[:id])
    if @motion.update(motion_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def show
    @user = User.find(current_user.id)
    @motion = Motion.find(params[:id])
  end

  def destroy
    @motion = Motion.find(params[:id])
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
end
