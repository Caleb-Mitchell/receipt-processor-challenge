require 'simplecov'
SimpleCov.start

ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "../receipt_processor"
require_relative "../lib/receipt"
require_relative "sample_test_data"

class MusicnotesTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def session
    last_request.env["rack.session"]
  end

  def test_no_payload_present
    post "/receipts/process"
    assert_equal 400, last_response.status
  end

  def test_target_payload_present
    post "/receipts/process", TEST_PAYLOAD_TARGET.to_json,
         "CONTENT_TYPE" => "application/json"
    assert_equal 200, last_response.status
  end

  def test_payload_present_but_not_valid_json
    post "/receipts/process", "test".to_json,
         "CONTENT_TYPE" => "application/json"
    assert_equal 400, last_response.status
  end

  def test_target_payload_json
    post "/receipts/process", TEST_PAYLOAD_TARGET.to_json,
         "CONTENT_TYPE" => "application/json"
    assert JSON.parse(last_response.body)
  end

  def test_target_response_headers
    post "/receipts/process", TEST_PAYLOAD_TARGET.to_json,
         "CONTENT_TYPE" => "application/json"
    assert_equal "application/json", last_response["Content-Type"]
  end

  def test_target_id_returned
    post "/receipts/process", TEST_PAYLOAD_TARGET.to_json,
         "CONTENT_TYPE" => "application/json"
    uuid_regexp = %r(\A[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-
                [89ab][a-f0-9]{3}-[a-f0-9]{12}\z)ix
    assert_match uuid_regexp, JSON.parse(last_response.body)["id"]
    assert_equal "id", JSON.parse(last_response.body).keys.first
  end

  def test_id_in_session
    post "/receipts/process", TEST_PAYLOAD_TARGET.to_json,
         "CONTENT_TYPE" => "application/json"
    assert_includes session.keys, JSON.parse(last_response.body)["id"]
  end

  def test_target_points
    post "/receipts/process", TEST_PAYLOAD_TARGET.to_json,
         "CONTENT_TYPE" => "application/json"
    assert_includes session.values, 28
  end

  def test_m_and_m_points
    post "/receipts/process", TEST_PAYLOAD_M_AND_M.to_json,
         "CONTENT_TYPE" => "application/json"
    assert_includes session.values, 109
  end

  def test_corner_store_points
    post "/receipts/process", TEST_PAYLOAD_CORNER_STORE.to_json,
         "CONTENT_TYPE" => "application/json"
    assert_includes session.values, 18
  end

  def test_successful_point_retrieval
    post "/receipts/process", TEST_PAYLOAD_TARGET.to_json,
         "CONTENT_TYPE" => "application/json"
    receipt_id = JSON.parse(last_response.body)["id"]

    get "/receipts/#{receipt_id}/points"
    assert_equal 200, last_response.status
  end

  def test_correct_points_retrieved_target
    post "/receipts/process", TEST_PAYLOAD_TARGET.to_json,
         "CONTENT_TYPE" => "application/json"
    receipt_id = JSON.parse(last_response.body)["id"]

    get "/receipts/#{receipt_id}/points"
    assert_equal 28, JSON.parse(last_response.body)["points"]
  end

  def test_correct_points_retrieved_m_and_m
    post "/receipts/process", TEST_PAYLOAD_M_AND_M.to_json,
         "CONTENT_TYPE" => "application/json"
    receipt_id = JSON.parse(last_response.body)["id"]

    get "/receipts/#{receipt_id}/points"
    assert_equal 109, JSON.parse(last_response.body)["points"]
  end

  def test_correct_points_retrieved_corner_store
    post "/receipts/process", TEST_PAYLOAD_CORNER_STORE.to_json,
         "CONTENT_TYPE" => "application/json"
    receipt_id = JSON.parse(last_response.body)["id"]

    get "/receipts/#{receipt_id}/points"
    assert_equal 18, JSON.parse(last_response.body)["points"]
  end

  def test_response_json_object
    post "/receipts/process", TEST_PAYLOAD_TARGET.to_json,
         "CONTENT_TYPE" => "application/json"
    receipt_id = JSON.parse(last_response.body)["id"]

    get "/receipts/#{receipt_id}/points"
    assert JSON.parse(last_response.body)
  end

  def test_no_receipt_found_for_id
    get "/receipts/invalid-id/points"
    assert_equal 404, last_response.status
  end
end
