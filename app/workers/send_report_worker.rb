class SendReportWorker
  include Sidekiq::Worker

  def perform(report_id)
    response = Requests::SendReportRequest.new(Report.find(report_id)).request

    if response.code == '200'
      logger.info("Report nr. #{report_id} was successfuly delivered!")
    else
      raise 'Report request FAILED'
    end
  end
end
