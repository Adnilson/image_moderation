class SendReportWorker
  include Sidekiq::Worker

  def perform(report_id)
    response = Requests::SendReportRequest.new(Report.find(report_id)).request

    if response.code == '200'
      # log
    else
      raise 'Report request failed'
    end
  end
end
