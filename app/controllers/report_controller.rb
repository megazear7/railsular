class ReportController < ApplicationController
  before_action :set_report, only: [:show, :update, :delete, :report]
  skip_before_action :verify_authenticity_token

  def index
    @reports = Report.all
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
    @report = Report.new(report_params)
    respond_to do |format|
      if @report.save
        format.json { render "report/show.json" }
      else
        format.json { render json: { message: 'create failed' }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @report.update(report_params)
        format.json { render "report/show.json" }
      else
        format.json { render "report/show.json", status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @report.destroy
        format.json { render json: { status: "delete success" } }
      else
        format.json { render "report/show.json", status: :unprocessable_entity }
      end
    end
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.permit(:name, :description)
    end
end
