class GeometryController < ApplicationController
  before_action :set_geometry, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

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
    @geometry = Geometry.create(geometry_params, params)
    # if the geometries have pre proccessing that needs done
    # create the job and then use machete to run the geometry job
    respond_to do |format|
      if @geometry.save
        format.json { render "geometry/show.json" }
      else
        format.json { render json: { message: 'create failed' } }
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
        format.json { render "geometry/show.json" }
      end
    end
  end

  def delete
    respond_to do |format|
      if @geometry.destroy
        format.json { render json: { message: "delete success" } }
      else
        @message = "delete failed"
        format.json { render "geometry/show.json" }
      end
    end
  end

  private
    def set_geometry
      @geometry = Geometry.find(params[:id])
    end

    def geometry_params
      params.permit(:name, :description, :geo_type)
    end
end
