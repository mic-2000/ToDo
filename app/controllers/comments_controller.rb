class CommentsController < ApplicationController
  before_action :set_task

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
    @comment = @task.comments.find(params[:id])
    @comment.destroy
    head :no_content
  end

  private
    def set_task
      @task = Task.find(params[:task_id])
    end

    def comment_params
      params.permit(:body, :file_name, :task_id)
    end
end
