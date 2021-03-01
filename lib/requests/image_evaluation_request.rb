# frozen_string_literal: true

module Requests

  API_URL = 'https://api.sightengine.com/1.0/check.json'

  class ImageEvaluationRequest
    def initialize(image_url)
      @image_url = image_url
    end

    def request
      uri = URI(API_URL)
      params = {
        models: 'nudity,wad,offensive',
        api_user: ENV['IMAGE_EVALUATOR_USER'],
        api_secret: ENV['IMAGE_EVALUATOR_SECRET'],
        url: @image_url
      }
      uri.query = URI.encode_www_form(params)

      Net::HTTP.get_response(uri)
    end
  end
end
