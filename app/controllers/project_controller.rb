class ProjectController < ApplicationController
  before_action :set_project, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

  def index
    @projects = Project.all
    respond_to do |format|
      format.json { render json: @projects }
      format.html { render json: @projects }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @project }
      format.html { render json: @project }
    end
  end

  def create
    @project = Project.new({name: params[:name], description: params[:description]})
    respond_to do |format|
      if @project.save
        format.json { render json: @project }
        format.html { render json: @project }
      else
        format.json { render json: "create failed" }
        format.html { render json: "create failed" }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.json { render json: { value: @project, status: "success" } }
        format.html { render json: { value: @project, status: "success" } }
      else
        format.json { render json: { value: @project, status: "failed" } }
        format.html { render json: { value: @project, status: "failed" } }
      end
    end
  end

  def delete
    if @project.destroy
      respond_to do |format|
        format.json { render json: { status: "success" } }
        format.html { render json: { status: "success" } }
      end
    else
      respond_to do |format|
        format.json { render json: { value: @project, status: "failed" } }
        format.html { render json: { value: @project, status: "failed" } }
      end
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.permit(:name, :description)
    end
end
