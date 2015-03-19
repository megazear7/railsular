class AdminDataController < ApplicationController
  before_action :set_app, only: [:show, :update]
  skip_before_action :verify_authenticity_token

  def show
    respond_to do |format|
      format.json
    end
  end

  def update
    respond_to do |format|
      if @app.update(geometry_params)
        format.json { render "admin_data/show.json" }
      else
        format.json { render "admin_data/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_app
      @app = App.find(1) # for now we only ever have 1 app
    end

    def geometry_params
      params.permit(:name, :app_hex_code, :test, :app_bin, :batch_queue)
    end
end
