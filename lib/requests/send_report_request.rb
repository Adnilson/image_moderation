module Requests
  class SendReportRequest
    def initialize(report)
      @report = report
    end

    def request
      uri = URI(report.caller_url)
      header = {'Content-Type': 'application/json'}
      body = {
        report: {
          report_id: report.id,
          user_id: report.user_id,
          result: report.result
        }
      }
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = body.to_json

      http.request
    end

    private

    attr_reader :report
  end
end
