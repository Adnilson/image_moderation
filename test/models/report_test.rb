require "test_helper"

class ReportTest < ActiveSupport::TestCase
  test "Creates Report successfully" do
    report = Report.create(user_id: 2, caller_url: 'some_url')
    assert report.save
  end

  test "Fails Report creation validations" do
    report = Report.create(user_id: 2)
    assert_not report.save
    assert_not_nil report.errors
  end

  test "Updates Report successfully" do
    report = Report.create(user_id: 2, caller_url: 'some_url')
    report.evaluated = true
    assert report.save
  end
end
