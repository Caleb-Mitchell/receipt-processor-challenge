require 'simplecov'

SimpleCov.start

ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "../receipt_processor"

class MusicnotesTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  # def setup
  # end
  #
  # def teardown
  # end

  def session
    last_request.env["rack.session"]
  end

  ### tests for POST request
  # test that id is stored in session

  # test that points are stored in session

  # test that points are correct for an example receipt
  # (test both examples given)

  # test that response is a JSON object

  # test that successful status code is given on a success
  # (this is based on api example)

  # test that unseccuessful status code is given on a failure
  # (this is based on api example)

  ### tests for GET request
  # test that correct response is given for both examples

  # test that response is a JSON object

  # test that successful status code is given on a success
  # (this is based on api example)

  # test that unseccuessful status code is given on a failure
  # (this is based on api example)
end
