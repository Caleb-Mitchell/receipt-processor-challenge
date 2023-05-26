require "securerandom"
require "sinatra"

require_relative "receipt_helpers"

SECRET = SecureRandom.hex(32)

configure do
  enable :sessions
  set :session_secret, SECRET
end

configure(:development) do
  require "sinatra/reloader"
end

# submit receipt as payload, save id and point total in memory, return id
post "/receipts/process" do
  request_body = request.body.read

  if receipt_invalid?(request_body)
    status 400
  else
    uuid = SecureRandom.uuid
    point_total = total_receipt_points(JSON.parse(request_body))
    session[uuid] = point_total

    status 200
    headers["Content-Type"] = "application/json"
    { id: uuid }.to_json
  end
end

# retrieve points awarded based on id passed via the URL
get "/receipts/:id/points" do
  point_total = session[params[:id]]

  if point_total.nil?
    status 404
  else
    status 200
    headers["Content-Type"] = "application/json"
    { points: point_total }.to_json
  end
end
