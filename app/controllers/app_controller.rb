class AppController < ApplicationController
  before_action :set_app, only: [:show, :update, :delete]
  skip_before_action :verify_authenticity_token

  def index
    @apps = App.all
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
    @app = App.new(app_params)
    respond_to do |format|
      if @app.save
        format.json { render "app/show.json" }
      else
        format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @app.update(app_params)
        format.json { render "app/show.json" }
      else
        format.json { render "app/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @app.destroy
        format.json { render json: { status: "delete success" } }
      else
        format.json { render "app/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_app
      @app = App.find(params[:id])
    end

    def app_params
      params.permit(:name, :email, :app_hex_code, :test, :app_bin, :batch_queue, :iterative)
    end
end
