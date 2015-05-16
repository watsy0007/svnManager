class ProjectsController < ApplicationController

  http_basic_authenticate_with name: "wangyan", password: "wangyan", except: [:index]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_path
  end

  private
  def project_params
    params.require(:project).permit(:name, :url, :path)
  end
end
