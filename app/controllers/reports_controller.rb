class ReportsController < ApplicationController
  def index
    @reports = Report
                .where(moderated: false)
                .order('graphic_score DESC NULLS LAST')
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])

    if @report.update(report_params.merge(moderated: true))
      redirect_to reports_url
    else
      redirect_to @report
    end
  end

  private

  def report_params
    params.require(:report).permit(:result)
  end
end
