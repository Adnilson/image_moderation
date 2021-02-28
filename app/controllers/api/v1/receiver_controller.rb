module Api
  module V1
    class ReceiverController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        @report = Report.new(report_params)
        image_url = URI.decode_www_form_component(params[:payload][:image_url])

        if @report.save
          ImageEvaluationWorker.perform_async(@report.id, image_url)
          AttachImageWorker.perform_async(@report.id, image_url)

          render json: @report, status: :created
        else
          render json: @report.errors, status: :unprocessable_entity
        end
      end

      def report_params
        params.require(:payload).permit(:user_id, :caller_url)
      end
    end
  end
end
