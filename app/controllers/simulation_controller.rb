Mime::Type.register "image/png", :png

class SimulationController < ApplicationController
  before_action :set_simulation, only: [:show, :update, :delete, :run, :image]
  skip_before_action :verify_authenticity_token

  def image
    variable_name = params[:variable_name]
    component_direction = params[:component_direction]
    view = params[:view]
    send_data open(@simulation.image_path(variable_name, component_direction, view) + ".png", "rb") { |f| f.read }
  end

  def attributes
    respond_to do |format|
      format.json { render json: { attributes: Simulation.attribute_details } }
    end
  end

  def run
    @simulation.submit
    respond_to do |format|
      format.json { render json: { message: 'simulation job has been submitted' } }
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
        format.json { render "simulation/show.json" }
      else
        format.json { render "simulation/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @simulation.destroy
        format.json { render json: { message: "delete success" } }
      else
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
