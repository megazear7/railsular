class ResultController < ApplicationController
  before_action :set_result, only: [:show, :update, :delete, :run]
  skip_before_action :verify_authenticity_token

  def index
    @results = Result.all
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
      @result = Result.create(result_params)
      if @result.save
        format.json { render "result/show.json" }
      else
        format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @result.update(result_params)
        format.json { render "result/show.json" }
      else
        format.json { render "result/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @result.destroy
        format.json { render json: { message: "delete success" } }
      else
        format.json { render "result/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_result
      @result = Result.find(params[:id])
    end

    def result_params
      params.permit(:simulation_id)
    end
end
