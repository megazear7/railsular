class GeometryTypeController < ApplicationController
  before_action :set_geometry_type, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

  def index
    @geometry_types = GeometryType.all
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
      @geometry_type = GeometryType.create(geometry_type_params)
      if @geometry_type.save
        format.json { render "geometry_type/show.json" }
      else
        format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @geometry_type.update(geometry_type_params)
        format.json { render "geometry_type/show.json" }
      else
        format.json { render "geometry_type/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @geometry_type.destroy
        format.json { render json: { message: "delete success" } }
      else
        format.json { render "geometry_type/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_geometry_type
      @geometry_type = GeometryType.find(params[:id])
    end

    def geometry_type_params
      params.permit(:name)
    end
end
