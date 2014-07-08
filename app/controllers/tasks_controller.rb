class TasksController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :through => :project, except: [:create]

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      render :show, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  def sort
    task_params[:priority].each_with_index do |task_id, index|
      task = @project.tasks.where(id: task_id).first
      task.update_attribute('priority', index) if task
    end
    render nothing: true
  end

  private
    def task_params
      params.require(:task).permit(:name, :deadline, :done, priority: [])
    end
end
