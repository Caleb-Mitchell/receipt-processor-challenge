def receipt_invalid?(receipt)
  receipt == "" || !JSON.parse(receipt).is_a?(Hash)
end

def score_retail_name(name)
  name.chars.grep(/[a-zA-Z0-9]/).size
end

def score_dollar_amount(total_price)
  if total_price % 1 == 0 && (total_price * 4) % 1 == 0
    75
  elsif total_price % 1 == 0
    50
  elsif (total_price * 4) % 1 == 0
    25
  else
    0
  end
end

def score_items(items)
  item_count_points = score_item_count(items.count)
  item_description_length_points = score_item_descriptions(items)

  return item_count_points, item_description_length_points
end

def score_item_count(item_count)
  (item_count / 2) * 5
end

def score_item_descriptions(items)
  total = 0
  items.each do |item|
    description_length = item["shortDescription"].strip.size
    if description_length % 3 == 0 && description_length != 0
      total += (item["price"].to_f * 0.2).ceil(0)
    end
  end
  total
end

def score_purchase_date(date)
  day_num = date.split("-")[2].to_i
  day_num.odd? ? 6 : 0
end

def score_purchase_time(time)
  purchase_hours = time.split(":")[0].to_i
  purchase_minutes = time.split(":")[1].to_i

  if purchase_hours >= 14 && purchase_hours < 16 && purchase_minutes != 0
    10
  else
    0
  end
end

def total_receipt_points(payload)
  retail_name_points = score_retail_name(payload["retailer"])
  dollar_amount_points = score_dollar_amount(payload["total"].to_f)

  item_count_points, item_desc_length_points = score_items(payload["items"])

  purchase_date_points = score_purchase_date(payload["purchaseDate"])
  purchase_time_points = score_purchase_time(payload["purchaseTime"])

  retail_name_points + dollar_amount_points + item_count_points +
    item_desc_length_points + purchase_date_points + purchase_time_points
end
