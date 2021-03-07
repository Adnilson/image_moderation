require "test_helper"
require "sidekiq/testing"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @headers = {
      'Authorization': ActionController::HttpAuthentication::Basic
        .encode_credentials(ENV['REPORTS_MODERATOR'], ENV['REPORTS_PASSWORD'])
    }
  end

  test "should get index" do
    get reports_url, headers: @headers
    assert_response :success
  end

  test "should update when report's decision is approved" do
    patch report_url(Report.last), headers: @headers, params: { report: { result: 'approved' } }

    assert_redirected_to reports_url
  end

  test "should update when report's decision is rejected" do
    patch report_url(Report.last), headers: @headers, params: { report: { result: 'rejected' } }

    assert_redirected_to reports_url
  end

  test "should redirect to edit when no params are passed" do
    patch report_url(Report.last), headers: @headers, params: { report: { result: '' } }

    assert_redirected_to edit_report_url(Report.last)
  end
end
