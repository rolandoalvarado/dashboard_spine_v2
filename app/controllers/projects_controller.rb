class ProjectsController < ApplicationController
  respond_to :html, :json
  
  def index
    @projects = Project.all
    respond_with @projects
  end

  def show
    @project = Project.find(params[:id])
    respond_with @project
  end

  def new
    @project = Project.new
    respond_with @project
  end
  
  def edit
    @project = Project.find(params[:id])
  end

  def create
    logger.info("params[:Project] : #{params[:Project].inspect}")
    @project = Project.new(params[:project])
    @project.save
    respond_with @project
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes(params[:project])
    respond_with @project
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    head :ok
  end
end
