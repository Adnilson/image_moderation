class ImageEvaluationWorker
  include Sidekiq::Worker

  def perform(report_id, image_url)
    response = Requests::ImageEvaluationRequest.new(image_url).request
    if response.status == 'success'
      score = ScoreCalculator.new(JSON.parse(response.body)).calculate

      Report.update(report_id, graphic_score: score, evaluated: true)
    else
      raise 'Request FAILED!'
    end
  end
end
