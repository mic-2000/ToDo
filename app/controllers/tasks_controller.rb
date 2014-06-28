class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @project = current_user.projects.find(params[:project_id])
    @tasks = @project.tasks
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render  json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  def sort
    @project = current_user.projects.find(params[:project_id])
    task_params[:priority].each_with_index do |task_id, index|
      task = @project.tasks.where(id: task_id).first
      task.update_attribute('priority', index) if task
    end
    render nothing: true
  end

  private
    def set_task
      @project = current_user.projects.find(params[:project_id])
      @task = @project.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :deadline, :done, priority: [])
    end
end
