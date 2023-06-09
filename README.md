
# receipt-processor-challenge

## Description

- An implementation of a receipt processor webservice, as described by the
  receipt-processor-challenge issued by [Fetch](https://fetch.com/).

- I chose to implement this using Ruby and the web framework Sinatra. With
  little configuration, Sinatra can store the necessary data on the server side
  in Sinatra's `session` object, allowing the necessary information to persist
  while the program is running.

## Instructions

- The provided `Dockerfile` should provide an easy way to get the program
  running, regardless of the host OS.

- First, after cloning this project repository, be sure to navigate into the
  project directory with `cd receipt-processor-challenge`, and then run the
  following commands to build and start the webservice, subsequently listening on port 4567
  as is the default for Sinatra applications:

```
docker build -t receipt_processor .
docker run -p 4567:4567 receipt_processor
```

- It should then be possible to reach the application via the URL
  `http://localhost:4567`. As described, if a `POST` request is issued to the
  endpoint `/receipts/process` with an appropriate JSON payload within the body
  of the request, the application returns a JSON object with an ID generated by
  the code. At this point, the program also determines how many points should be
  earned based on the payload and the requirements listed within the challenge,
  and saves the ID and point total as a key/value pair within the session, to be
  retrieved later.
- If this same ID is then used within the URL for a `GET` request issued to the
  endpoint `/receipts/{id}/points`, the application returns a JSON object
  containing the number of points associated with that ID, in the format
  described by the challenge.
