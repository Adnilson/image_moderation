module ReportsHelper
  def score(report)
    if report.graphic_score
      "#{(report.graphic_score * 100).floor}% of possible graphic content"
    else
      "Not evaluated yet"
    end
  end
end
