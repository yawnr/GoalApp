class GoalsController < ApplicationController
  before_action :require_owner, only: [:edit, :update, :destroy]

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    if @goal.save
      redirect_to(user_url(current_user))
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to(user_url(current_user))
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if params[:completed].nil?
      @goal.completed = false
    end

    if @goal.update(goal_params)
      redirect_to(user_url(current_user))
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to(user_url(current_user))
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to(user_url(current_user))
  end

  private
  def goal_params
    params.require(:goal).permit(:goal_text, :completed, :private)
  end

  def require_owner
    goal = Goal.find(params[:id])
    if goal.user_id != current_user.id
      flash[:errors] = ["You can't update someone else's shit"]
      redirect_to user_url(current_user)
    end
  end


end
