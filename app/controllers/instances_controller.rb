class InstancesController < ApplicationController
  respond_to :html, :json
  
  def index
    @instances = Instance.all
    respond_with @instances
  end

  def show
    @instance = Instance.find(params[:id])
    respond_with @instance
  end

  def new
    @instance = Instance.new
    respond_with @instance
  end
  
  def edit
    @instance = Instance.find(params[:id])
  end

  def create
    logger.info("params[:Instance] : #{params[:Instance].inspect}")
    @instance = Instance.new(params[:instance])
    @instance.save
    respond_with @instance
  end

  def update
    @instance = Instance.find(params[:id])
    @instance.update_attributes(params[:instance])
    respond_with @instance
  end

  def destroy
    @instance = Instance.find(params[:id])
    @instance.destroy
    head :ok
  end
end
