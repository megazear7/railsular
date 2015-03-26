class JoinValueController < ApplicationController
  skip_before_action :verify_authenticity_token

  def results_simulations
    @result_simulations = ResultSimulation.all
    respond_to do |format|
      format.json { render "join_value/results_simulations.json" }
    end
  end

  def add_result_simulation
    @rs = ResultSimulation.new(result_simulation_params)
    respond_to do |format|
      if @rs.save
        format.json { render json: { message: "success", result_simulation: { result_id: @rs.result_id, simulation_id: @rs.simulation_id} } }
      else
        format.json { render json: { message: "failure" }, status: :unprocessable_entity }
      end
    end
  end

  private
    def result_simulation_params
      params.permit(:simulation_id, :result_id)
    end
end
