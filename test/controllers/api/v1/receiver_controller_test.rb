require "test_helper"
require "sidekiq/testing"

module Api
  module V1
    class ReceiverControllerTest < ActionDispatch::IntegrationTest
      test "should get create and succeed" do
        post '/api/v1/process', params: { payload: {
          user_id: 30,
          image_url: 'https://rubyonrails.org/images/imagine.png',
          caller_url: 'https://worldoftanks.org/'
        } }, as: :json

        assert_response :success
      end

      test "should get create and fail" do
        post '/api/v1/process', params: { payload: {
          user_id: 30,
          image_url: 'https://rubyonrails.org/images/imagine.png',
        } }, as: :json

        assert_response :unprocessable_entity
      end
    end
  end
end
