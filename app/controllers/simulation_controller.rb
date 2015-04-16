Mime::Type.register "image/png", :png

class SimulationController < ApplicationController
  before_action :set_simulation, only: [:show, :update, :delete, :run, :image, :movie_frame, :report, :download_results]
  skip_before_action :verify_authenticity_token

  def download_results
    if File.exist? @simulation.results_zip_path
      send_file @simulation.results_zip_path, type: 'application/zip', filename: 'Results.zip'
    else
      respond_to do |format|
        format.json { render json: { message: "results zip does not exist" } }
      end
    end
  end

  def movie_slice_normals
    simulations = Simulation.where(id: params[:simulation_ids].split(','))

    respond_to do |format|
      format.json { render json: { slice_normals: Simulation.movie_slice_normals(simulations) } }
    end
  end

  def movie_variable_names
    simulations = Simulation.where(id: params[:simulation_ids].split(','))
    slice_normal = params[:slice_normal]

    respond_to do |format|
      format.json { render json: { variable_names: Simulation.movie_variable_names(simulations, slice_normal) } }
    end
  end

  def movie_component_directions
    simulations = Simulation.where(id: params[:simulation_ids].split(','))
    slice_normal = params[:slice_normal]
    variable_name = params[:variable_name]

    respond_to do |format|
      format.json { render json: { component_directions: Simulation.movie_component_directions(simulations, slice_normal, variable_name) } }
    end
  end

  def frame_count
    simulations = Simulation.where(id: params[:simulation_ids].split(','))
    slice_normal = params[:slice_normal]
    variable_name = params[:variable_name]
    component_direction = params[:component_direction]

    respond_to do |format|
      format.json { render json: { frame_count: Simulation.movie_frame_count(simulations, slice_normal, variable_name, component_direction) } }
    end
  end

  def movie_frame
    slice_normal = params[:slice_normal]
    variable_name = params[:variable_name]
    component_direction = params[:component_direction]
    frame = params[:frame]

    if slice_normal.present? and variable_name.present? and component_direction.present?
      send_data open(@simulation.frame_path(slice_normal, variable_name, component_direction, frame), "rb") { |f| f.read }
    else
      send_data open(File.join(Rails.root, "public", "placeholder.png"), "rb") { |f| f.read }
    end
  end

  def curve_variable_names
    simulations = Simulation.where(id: params[:simulation_ids].split(','))

    respond_to do |format|
      format.json { render json: { variable_names: Simulation.curve_variable_names(simulations) } }
    end
  end

  def image_variable_names
    simulations = Simulation.where(id: params[:simulation_ids].split(','))

    respond_to do |format|
      format.json { render json: { variable_names: Simulation.image_variable_names(simulations) } }
    end
  end

  def image_component_directions
    simulations = Simulation.where(id: params[:simulation_ids].split(','))
    variable_name = params[:variable_name]

    respond_to do |format|
      format.json { render json: { component_directions: Simulation.image_component_directions(simulations, variable_name) } }
    end
  end

  def image_views
    simulations = Simulation.where(id: params[:simulation_ids].split(','))
    variable_name = params[:variable_name]
    component_direction = params[:component_direction]

    respond_to do |format|
      format.json { render json: { views: Simulation.image_views(simulations, variable_name, component_direction) } }
    end
  end

  def image
    variable_name = params[:variable_name]
    component_direction = params[:component_direction]
    view = params[:view]
    if variable_name.present? and component_direction.present? and view.present?
      send_data open(@simulation.image_path(variable_name, component_direction, view) + ".png", "rb") { |f| f.read }
    else
      send_data open(File.join(Rails.root, "public", "placeholder.png"), "rb") { |f| f.read }
    end
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

  def report
    subject = "TotalSim App Issue Report: #{App.find(1).app_hex_code}"
    body = "app: #{App.find(1).app_hex_code}\n" +
      "type: simulation\n" +
      "id: #{@simulation.id}\n" +
      "path: #{@simulation.job_directory_path}\n" +
      "user: <user>\n" +
      "datetime: #{DateTime.now}"
    body += "\nmessage: #{params[:message]}" if params[:message]
    system "echo '#{body}' | mutt -s '#{subject}' #{App.find(1).email}"
    respond_to do |format|
      format.json { render json: { message: 'report sent' } }
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
