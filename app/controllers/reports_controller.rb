class ReportsController < ApplicationController

  http_basic_authenticate_with name: ENV['REPORTS_MODERATOR'],
                               password: ENV['REPORTS_PASSWORD']

  def index
    @reports = Report
                .where(moderated: false)
                .order('graphic_score DESC NULLS LAST')
                .page(params[:page])
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])

    if @report.update(report_params.merge(moderated: true))
      SendReportWorker.perform_async(@report.id)

      redirect_to reports_url
    else
      redirect_to edit_report_path(@report)
    end
  end

  private

  def report_params
    params.require(:report).permit(:result)
  end
end
