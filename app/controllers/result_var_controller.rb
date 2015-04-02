class ResultVarController < ApplicationController
  before_action :set_result_var, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

  def index
    @result_vars = ResultVar.all
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
    @result_var = ResultVar.new(result_var_params)
    respond_to do |format|
      if @result_var.save
        format.json { render "result_var/show.json" }
      else
        format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @result_var.update(result_var_params)
        format.json { render "result_var/show.json" }
      else
        format.json { render "result_var/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @result_var.destroy
        format.json { render json: { status: "delete success" } }
      else
        format.json { render "result_var/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_result_var
      @result_var = ResultVar.find(params[:id])
    end

    def result_var_params
      params.permit(:name, :app_id)
    end
end
