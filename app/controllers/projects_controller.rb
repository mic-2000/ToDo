class ProjectsController < ApplicationController
  load_and_authorize_resource except: [:create]

  def index
    @projects = current_user.projects
    render :index, status: :ok
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      render :show, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render :show, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    head :no_content
  end

  private
    def project_params
      params.require(:project).permit(:name, :priority)
    end
end
