require_relative "scorable"

class Receipt
  include Scorable

  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def invalid?
    @payload == "" || !JSON.parse(@payload).is_a?(Hash)
  end

  def score_receipt
    receipt = JSON.parse(@payload)

    score_retail_name(receipt["retailer"]) +
      score_dollar_amount(receipt["total"].to_f) +
      score_items(receipt["items"]) +
      score_purchase_date(receipt["purchaseDate"]) +
      score_purchase_time(receipt["purchaseTime"])
  end
end
