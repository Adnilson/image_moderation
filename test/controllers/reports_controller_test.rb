require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reports_url
    assert_response :success
  end

  test "should get update and approve" do
    patch report_url(Report.last), params: { report: { result: 'approved' } }

    assert_redirected_to reports_url
  end

  test "should get update and reject" do
    patch report_url(Report.last), params: { report: { result: 'rejected' } }

    assert_redirected_to reports_url
  end

  test "should get update and fail" do
    patch report_url(Report.last), params: { report: { result: '' } }

    assert_redirected_to edit_report_url(Report.last)
  end
end
