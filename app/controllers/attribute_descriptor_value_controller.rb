class AttributeDescriptorValueController < ApplicationController
  before_action :set_attribute_descriptor_value, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

  def index
    @attribute_descriptor_values = AttributeDescriptorValue.all
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
      @attribute_descriptor_value = AttributeDescriptorValue.create(attribute_descriptor_value_params)
      if @attribute_descriptor_value.save
        format.json { render "attribute_descriptor_value/show.json" }
      else
        format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attribute_descriptor_value.update(attribute_descriptor_value_params)
        format.json { render "attribute_descriptor_value/show.json" }
      else
        format.json { render "attribute_descriptor_value/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @attribute_descriptor_value.destroy
        format.json { render json: { message: "delete success" } }
      else
        format.json { render "attribute_descriptor_value/show.json", status: :unprocessable_entity }
      end
    end
  end
  
  private
    def set_attribute_descriptor_value
      @attribute_descriptor_value = AttributeDescriptorValue.find(params[:id])
    end

    def attribute_descriptor_value_params
      params.permit(:value, :attribute_descriptor_id)
    end
end
