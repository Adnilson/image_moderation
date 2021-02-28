module Requests
  class ImageEvaluationRequest
    def initialize(image_url)
      @image_url = image_url
    end

    def request
      Faraday.new(
        url: 'https://api.sightengine.com/1.0/check.json',
        params: {
          models: 'nudity,wad,offensive',
          api_user: ENV['IMAGE_EVALUATOR_USER'],
          api_secret: ENV['IMAGE_EVALUATOR_SECRET'],
          url: @image_url
        }
      ).get
    end
  end
end
