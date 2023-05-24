require "securerandom"
require "sinatra"

SECRET = SecureRandom.hex(32)

configure do
  enable :sessions
  set :session_secret, SECRET
end

configure(:development) do
  require "sinatra/reloader"
end

# two end points necessary, one GET and one POST.

# endpoint: process receipts (POST).
# payload is JSON representing a receipt.
# response should be JSON containing an id for the receipt.
post "/receipts/process" do
  # save the JSON payload, assigned to an local variable.

  # determine how many points should be awared to the receipt, and save to a
  # variable.

  # generate a unique UUID to represent the receipt.

  # save to session hash, as a hash itself, where "id": $id is one of two
  # key/value pairs, and the other is "points": $number_of_points.

  # return the id/id key/value pair as a JSON object.
end

# endpoint: get points
# desired id should be passed through the url
# response should be
get "/receipts/:id/points" do
  # return a json object containing the number of points
  # i.e. "points": $number_of_points
end
