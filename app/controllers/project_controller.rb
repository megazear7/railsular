class ProjectController < ApplicationController
  before_action :set_project, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

  def index
    @projects = Project.all
    respond_to do |format|
      format.json
    end
  end

  def show
    respond_to do |format|
      format.json
    end
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.json { render "project/show.json" }
      else
        format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        @message = "update success"
        format.json { render "project/show.json" }
      else
        @message = "update failed"
        format.json { render "project/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @project.destroy
        format.json { render json: { status: "delete success" } }
      else
        @message = "delete failed"
        format.json { render "project/show.json", status: :unprocessable_entity }
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
