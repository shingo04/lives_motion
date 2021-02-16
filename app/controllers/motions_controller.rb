class MotionsController < ApplicationController
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
    @motion = Motion.find(params[:id])
  end

  def update
    @motion = Motion.find(params[:id])
    if @motion.update(motion_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def show
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
