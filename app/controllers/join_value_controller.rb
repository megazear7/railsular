class JoinValueController < ApplicationController
  def results_simulations
    @result_simulations = ResultSimulation.all
    respond_to do |format|
      format.json { render "join_value/results_simulations.json" }
    end
  end
end
