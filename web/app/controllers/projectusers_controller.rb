class ProjectusersController < ApplicationController

  http_basic_authenticate_with name: "wangyan", password: "wangyan", only: [:destroy, :create]

  def create
    @project = Project.find(params[:project_id])
    @user = @project.projectusers.create(user_params)
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:project_id])
    @user = @project.projectusers.find(params[:id])
    @user.destroy
    redirect_to project_path(@project)
  end

  private
  def user_params
    params.require(:projectuser).permit(:name, :password)
  end

end
