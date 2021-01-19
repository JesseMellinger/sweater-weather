# Sweater Weather

## About the Project

This is an API application to plan road trips. This app allows users to see the current weather as well as the forecasted weather at the destination.

## How to Install

For usage on your local machine follow the instructions listed below:

```
git clone git@github.com:GetThatFlightOut/GTFO-FE.git
cd swweater-weather
bundle install
rake db:{create,migrate}
firgaro install
# Setup ENV Variables in application.yml: 
# MAPQUEST_API_KEY: YOUR-MAPQUEST-API-KEY
# OPENWEATHER_API_KEY: YOUR-OPENWEATHER-API-KEY
# FLICKR_API_KEY: YOUR-FLICKR-API-KEY
rails server
open Postman and hit the endpoints below
```

## API Endpoints

#### Request:

```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

#### Response:

```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "datetime": "2020-09-30 13:27:03 -0600",
        "temperature": 79.4,
        etc
      },
      "daily_weather": [
        {
          "date": "2020-10-01",
          "sunrise": "2020-10-01 06:10:43 -0600",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00:00",
          "wind_speed": "4 mph",
          "wind_direction": "from NW",
          etc
        },
        {...} etc
      ]
    }
  }
}
```

#### Request:

```
GET /api/v1/backgrounds?location=denver,co
Content-Type: application/json
Accept: application/json
```

#### Response:

```
{
  "data": {
    "type": "image",
    "id": null,
    "attributes": {
      "image": {
        "location": "denver,co",
        "image_url": "https://pixabay.com/get/54e6d4444f50a814f1dc8460962930761c38d6ed534c704c7c2878dd954dc451_640.jpg",
        "credit": {
          "source": "pixabay.com",
          "author": "quinntheislander",
          "logo": "https://pixabay.com/static/img/logo_square.png"
        }
      }
    }
  }
}
```

#### Request:

(send JSON payload in body of request)

```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

#### Response:

```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

#### Request:

(send JSON payload in body of request)

```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

#### Response:

```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

#### Request:

(send JSON payload in body of request)

```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

#### Response:

```
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```

## Database Architecture

![sweater_weather_db](https://user-images.githubusercontent.com/29828129/105099562-1c6e7900-5a69-11eb-9ca0-f07c03fcbd1d.png)

## Built With

* Ruby 2.5.3

* Rails 5.2.4.3

* [Faraday Gem](https://github.com/lostisland/faraday) to make calls to our API service.

* [Figaro Gem](https://github.com/laserlemon/figaro) to keep confidential information like API keys secure.

* [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem was used to ensure that we covered 100% of our code with unit testing. 

* [bcrypt](https://github.com/codahale/bcrypt-ruby) gem used to implement hashing algorithm for `Users` table. 

## Contact

### Jesse Mellinger: [LinkedIn](https://www.linkedin.com/in/jesse-mellinger/) || [Email](mailto:jesse.m.mellinger@gmail.com)
