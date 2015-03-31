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

    @example = CSV.generate do |csv|
      csv << ["x", "y1", "y2"]
      csv << ["0", "0", "3"]
      csv << ["1", "1", "6"]
      csv << ["2", "2", "12"]
      csv << ["3", "4", "24"]
      csv << ["4", "6", "34"]
    end

    respond_to do |format|
      format.json
      format.csv { render text: @example }
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
      params.permit(:x_var, :y_var, :result_type)
    end
end
