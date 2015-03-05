class GeometryController < ApplicationController
  before_action :set_geometry, only: [:show, :update, :delete, :run, :file_form]
  skip_before_action :verify_authenticity_token

  def file_form
    render layout: false
  end

  def run
    # create a job (or jobs) and associate them with this simulation
    # then use machete to run the jobs
    respond_to do |format|
      format.json { render json: { message: 'geometry/:id/run is not yet implemented' } }
    end
  end

  def types
    @geometry_types = {}
    Geometry.geo_types.each do |geo_type|
      @geometry_types[geo_type] = {
        name: geo_type,
        attributes: Geometry.geo_attribute_names(geo_type),
        assigned_attributes: AssignedGeometry.assigned_geo_attribute_names(geo_type),
      }
    end
    respond_to do |format|
      format.json { render json: @geometry_types }
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

  def update
    respond_to do |format|
      if @geometry.update(geometry_params, params)
        @message = "update success"
        format.json { render "geometry/show.json" }
      else
        @message = "update failed"
        format.json { render "geometry/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @geometry.destroy
        format.json { render json: { message: "delete success" } }
      else
        @message = "delete failed"
        format.json { render "geometry/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_geometry
      @geometry = Geometry.find(params[:id])
    end

    def geometry_params
      params.permit(:name, :description, :geo_type, :project_id, :geo, :final)
    end
end
