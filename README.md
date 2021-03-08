# Image moderation

This is a repo of an image moderation microservice.

Things you may want to cover:

As you asked to have docker, all components are in a network. Main app, Sidekiq, Redis and PostgreSQL

## Instructions

### Configure environment variables

Create .env file and copy contents from .env.development

e.g.

`cp .env.development .env`


If you dont want to use AWS S3 change the following config on `config/environments/development.rb` to local:

`config.active_storage.service = :local`

If you wish to use S3 fill the AWS credentials on the .env file

```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION
AWS_BUCKET
```


To use the image recognition and evaluation api, create a free account on https://sightengine.com

Introduce your credentials on .env

```
IMAGE_EVALUATOR_USER
IMAGE_EVALUATOR_SECRET
```

Configure both variables in order to see and moderate the reports

```
REPORTS_MODERATOR
REPORTS_PASSWORD
```

### Build the app for development

`docker-compose build`

* Enliven the containers

`docker-compose up`

* Set up the database

`docker-compose run web rails db:create`

`docker-compose run web rails db:schema:load`


* Run tests

`docker-compose run web rails test`


To create an image report you need to send a request with a json body.
I will show you below a ruby script that does it:

```
require 'net/http'
require 'uri'
require 'json'

# gave receiver before but better not, for security reasons
uri = URI.parse('http://localhost:3000/api/v1/process')

header = {'Content-Type': 'application/json'}
body = {
  payload: {
    user_id: 30,
    image_url: 'https://planetill.com/wp-content/uploads/2010/08/pimp-c.jpg',
    caller_url: 'http://localhost:5000/images'
  }
}

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)
request.body = body.to_json

response = http.request(request)
```

You can go to the app and check the reports list ordered by graphic score

The callback url or better the `caller_url` should expect a post with an application/json header the following body:

```
{
  "report": {
    "report_id": report.id,
    "user_id": report.user_id,
    "result": report.result
  }
}
```
