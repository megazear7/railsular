class SimulationController < ApplicationController
  before_action :set_simulation, only: [:show, :update, :delete, :run]
  skip_before_action :verify_authenticity_token

  def attributes
    respond_to do |format|
      format.json { render json: { attributes: Simulation.attribute_names } }
    end
  end

  def run
    # create a job (or jobs) and associate them with this simulation
    # then use machete to run the jobs
    respond_to do |format|
      format.json { render json: { message: 'simulation/:id/run is not yet implemented' } }
    end
  end

  def index
    @simulations = Simulation.all
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
      if Project.exists?(params[:project_id])
        @simulation = Simulation.create(simulation_params, params)
        if @simulation.save
          format.json { render "simulation/show.json" }
        else
          format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
        end
      else
        format.json { render json: { message: 'project doesnt exist' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @simulation.update(simulation_params, params)
        @message = "update success"
        format.json { render "simulation/show.json" }
      else
        @message = "update failed"
        format.json { render "simulation/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @simulation.destroy
        format.json { render json: { message: "delete success" } }
      else
        @message = "delete failed"
        format.json { render "simulation/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_simulation
      @simulation = Simulation.find(params[:id])
    end

    def simulation_params
      params.permit(:name, :description, :project_id, :final)
    end
end
