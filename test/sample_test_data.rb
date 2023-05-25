TEST_PAYLOAD_CORNER_STORE = {
  retailer: "-------",
  purchaseDate: "2022-03-1",
  purchaseTime: "14:00",
  items: [
    {
      shortDescription: "Water",
      price: "2.00"
    }, {
      shortDescription: "",
      price: "3.00"
    }, {
      shortDescription: "Pencil",
      price: "2.02"
    }, {
      shortDescription: "     Eraser",
      price: "2.00"
    }
  ],
  total: "9.02"
} # => should return 18 points

=begin
0 - No alphanumeric characters in retailer name
0 - total not a round dollar amount, or a multiple of 0.25
10 - 4 items (2 * 2)
2 - "Pencil" and "Eraser" each earn 1 point, at 6 characters each
(this helped me catch a bug where an empty description string would earn points)
6 - day in purchase date is odd
0 - purchase time is 2:00pm, which is not after 2:00pm
=end

TEST_PAYLOAD_TARGET = {
  retailer: "Target",
  purchaseDate: "2022-01-01",
  purchaseTime: "13:01",
  items: [
    {
      shortDescription: "Mountain Dew 12PK",
      price: "6.49"
    }, {
      shortDescription: "Emils Cheese Pizza",
      price: "12.25"
    }, {
      shortDescription: "Knorr Creamy Chicken",
      price: "1.26"
    }, {
      shortDescription: "Doritos Nacho Cheese",
      price: "3.35"
    }, {
      shortDescription: "   Klarbrunn 12-PK 12 FL OZ  ",
      price: "12.00"
    }
  ],
  total: "35.35"
}

TEST_PAYLOAD_M_AND_M = {
  retailer: "M&M Corner Market",
  purchaseDate: "2022-03-20",
  purchaseTime: "14:33",
  items: [
    {
      shortDescription: "Gatorade",
      price: "2.25"
    }, {
      shortDescription: "Gatorade",
      price: "2.25"
    }, {
      shortDescription: "Gatorade",
      price: "2.25"
    }, {
      shortDescription: "Gatorade",
      price: "2.25"
    }
  ],
  total: "9.00"
}
