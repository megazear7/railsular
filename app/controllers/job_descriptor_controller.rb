class JobDescriptorController < ApplicationController
  before_action :set_job_descriptor, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

  def index
    @job_descriptors = JobDescriptor.all
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
    respond_to do |format|
      @job_descriptor = JobDescriptor.create(job_descriptor_params)
      if @job_descriptor.save
        format.json { render "job_descriptor/show.json" }
      else
        format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_descriptor.update(job_descriptor_params)
        format.json { render "job_descriptor/show.json" }
      else
        format.json { render "job_descriptor/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @job_descriptor.destroy
        format.json { render json: { message: "delete success" } }
      else
        format.json { render "job_descriptor/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_job_descriptor
      @job_descriptor = JobDescriptor.find(params[:id])
    end

    def job_descriptor_params
      params.permit(:name, :job_type, :script_number, :setup_method, :test_compute_resources, :prod_compute_resources, :test_walltime, :prod_walltime)
    end
end
