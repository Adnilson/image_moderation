class ReceiverController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @report = Report.new(report_params)
    image_url = params[:payload][:image_url]

    if @report.save
      ImageEvaluationWorker.perform_async(@report.id, image_url)
      # Attach image

      render json: @report, status: :created
    else
      render json: @report.errors, status: :unprocessable_entity
  end

  def report_params
    params.require(:payload).permit(:user_id, :caller_url)
  end
end
