class AttributeDescriptorController < ApplicationController
  before_action :set_attribute_descriptor, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

  def index
    @attribute_descriptors = AttributeDescriptor.all
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
      @attribute_descriptor = AttributeDescriptor.create(attribute_descriptor_params)
      if @attribute_descriptor.save
        format.json { render "attribute_descriptor/show.json" }
      else
        format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attribute_descriptor.update(attribute_descriptor_params)
        format.json { render "attribute_descriptor/show.json" }
      else
        format.json { render "attribute_descriptor/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @attribute_descriptor.destroy
        format.json { render json: { message: "delete success" } }
      else
        format.json { render "attribute_descriptor/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_attribute_descriptor
      @attribute_descriptor = AttributeDescriptor.find(params[:id])
    end

    def attribute_descriptor_params
      params.permit(:name, :attr_type, :display, :validation, :usage, :geometry_type_id)
    end
end
