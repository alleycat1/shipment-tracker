class ProjectsController < ApplicationController

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(params.require(:project).permit(:name))
    authorize @project

    if @project.save
      redirect_to(root_path)
    else
      render :new
    end
  end

end
