class CommentsController < ApplicationController
  load_and_authorize_resource :task
  load_and_authorize_resource :through => :task, except: [:create]

  def index
    @comments = @task.comments
  end

  def create
    @comment = @task.comments.new(comment_params)
    if @comment.save
      render :show, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :file_name, :task_id)
    end
end
