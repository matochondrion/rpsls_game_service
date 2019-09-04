# Game Server

## Overview

## Setup

### Ruby Version: 2.6.4

You may want to ues the [RVM Ruby Version Manager](https://rvm.io/rvm/install)

to install Ruby version 2.6.3.

### Installation

First, install bundler, if you haven’t:

```
gem install bundler
```

Install Sinatra and dependencies:

Note, when using rvm, you may need to ues `rvmsudo` instead of `sudo`
when running `bundle install`.

```
bundle install
```

If installing on remote server, make sure port the default port, 4567 is open.
(winner_server will require port 4568 to be open by default).

## API

### `GET: /choice`

Get a randomly generated choice (for clients that don’t trust the server)

### `GET: /choices`

Get all the choices that are usable for the frontend. Returns json array of
possible choices. Note, the choice data origiantes from the _Winner Service_
microservice.

Example JSON Response body:

```
[
  {
    "choice": {
      "id": 1,
      "name": "rock"
    }
  },
  {
    "choice": {
      "id": 2,
      "name": "paper"
    }
  },
  {
    "choice": {
      "id": 3,
      "name": "scissors"
    }
  },
  {
    "choice": {
      "id": 4,
      "name": "lizard"
    }
  },
  {
    "choice": {
      "id": 5,
      "name": "spock"
    }
  }
]
```

### `POST: /play`

Play a round (for servers that don’t trust the client)

Example JSON Response body:

```
{
  "results": string [12] (win, lose, tie),
  "player": choice_id,
  "computer":  choice_id
}
```

## Credits

### Github Repo: React Sinatra Example

[https://github.com/alanbsmith/react-sinatra-example](https://github.com/alanbsmith/react-sinatra-example)

Starter React setup for implimenting a React Project with Sinatra. I merged the
relative files into the Sinatra app, and made Sinatra config changes in the
`app.rb` file in order to serev static files fromt the React project rather
than the default Sinatra locations.

### Gem `sinatra-contrib`:

Includes a number of useful itilies like

### Gem `thin`:

Using the `thin` webserver instead of default `webrick` because it's more
performant and has more features, as recmmended by Sinatra
documentation.

### Gem `erubis`:

View templating engine.

### Gem: `httprb`:

Using `httprb` instead of Ruby's `Net::HTTP` because `httprb` is simpler.

Read more here:
http://twin.github.io/httprb-is-great/

https://github.com/httprb/http
