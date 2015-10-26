class CommentsController < ApplicationController

  def new
    if params[:goal_id]
      @id = params[:goal_id]
      render :goal
    else
      @id = params[:user_id]
      render :user
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      if @comment.commentable_type == "Goal"
        redirect_to(user_url(Goal.find(@comment.commentable_id).user_id))
      else
        redirect_to(user_url(@comment.commentable_id))
      end
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to user_url(current_user)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

end
