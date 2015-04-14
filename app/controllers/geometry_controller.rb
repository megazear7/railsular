class GeometryController < ApplicationController
  before_action :set_geometry, only: [:show, :update, :delete, :run, :file_form, :update_file, :report]
  skip_before_action :verify_authenticity_token

  def run
    @geometry.submit
    respond_to do |format|
      format.json { render json: { message: 'geometry job has been submitted' } }
    end
  end

  def types
    @geometry_types = {}
    Geometry.geo_types.each do |geo_type|
      @geometry_types[geo_type] = {
        name: geo_type,
        id: GeometryType.find_by(name: geo_type).id,
        attributes: Geometry.geo_attributes[geo_type],
        assigned_attributes: AssignedGeometry.assigned_geo_attributes[geo_type]
      }
    end
    respond_to do |format|
      format.json { render json: @geometry_types }
    end
  end

  def report
    subject = "TotalSim App Issue Report: #{App.find(1).app_hex_code}"
    body = "app: #{App.find(1).app_hex_code}\n" +
      "type: geometry (#{@geometry.geometry_type.name})\n" +
      "id: #{@geometry.id}\n" +
      "path: #{@geometry.job_directory_path}\n" +
      "user: <user>\n" +
      "datetime: #{DateTime.now}"
    body += "\nmessage: #{params[:message]}" if params[:message]
    system "echo '#{body}' | mutt -s '#{subject}' #{App.find(1).email}"
    respond_to do |format|
      format.json { render json: { message: 'report sent' } }
    end
  end

  def index
    @geometries = Geometry.all
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
        @geometry = Geometry.create(geometry_params, params)
        if @geometry.save
          format.json { render "geometry/show.json" }
        else
          format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
        end
      else
        format.json { render json: { message: 'project doesnt exist' }, status: :unprocessable_entity }
      end
    end
  end

  def update_file
    respond_to do |format|
      if @geometry.update(geometry_file_params, params)
        format.json { render "geometry/show.json" }
      else
        format.json { render "geometry/show.json", status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @geometry.update(geometry_params, params)
        format.json { render "geometry/show.json" }
      else
        format.json { render "geometry/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @geometry.destroy
        format.json { render json: { message: "delete success" } }
      else
        format.json { render "geometry/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_geometry
      @geometry = Geometry.find(params[:id])
    end

    def geometry_file_params
      params.permit(:geo)
    end

    def geometry_params
      params.permit(:description, :geometry_type_id, :project_id, :final)
    end
end
