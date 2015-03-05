class AssignedGeoController < ApplicationController
  before_action :set_assigned_geo, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

  def index
    @assigned_geos = AssignedGeometry.all
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
      if Simulation.exists?(params[:simulation_id]) and Geometry.exists?(params[:geometry_id])
        @assigned_geo = AssignedGeometry.create(assigned_geo_params, params)
        if @assigned_geo.save
          format.json { render "assigned_geo/show.json" }
        else
          format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
        end
      else
        format.json { render json: { message: 'simulation or geometry does not exist' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @assigned_geo.update(assigned_geo_params, params)
        @message = "update success"
        format.json { render "assigned_geo/show.json" }
      else
        @message = "update failed"
        format.json { render "assigned_geo/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @assigned_geo.destroy
        format.json { render json: { message: "delete success" } }
      else
        @message = "delete failed"
        format.json { render "assigned_geo/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_assigned_geo
      @assigned_geo = AssignedGeometry.find(params[:id])
    end

    def assigned_geo_params
      params.permit(:geometry_id, :simulation_id)
    end
end
