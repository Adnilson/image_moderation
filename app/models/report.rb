class Report < ApplicationRecord
  has_one_attached :image

  after_update :send_report_result


  def send_report_result
    SendReportWorker.perform_async(id)
  end
end
