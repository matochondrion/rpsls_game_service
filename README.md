# RPSLS game_service

## Overview

The `game_service` has two roles, serving a React Single Page Application,
and hosting several API endpoints. The endpoints deliver necessary data to the
SPA, and accept data from it.

Furthermore, it retrieves data from, and sends data to, the `winner_service`.
This way the `winner_service` can scale independently of the `game_service` and
different implementations of `game_service` can be developed without
having to duplicate the game logic. This structure also allows the React
client app to communicate with services on other domains without setting up
CORS rules and functionality on the servers and in the front-end app.

## Setup

### Installation

Ruby Version: 2.6.4

You may want to use the [RVM Ruby Version Manager](https://rvm.io/rvm/install)
to install Ruby version 2.6.3.

- First, install bundler, if you haven't:

```
gem install bundler
```

- Install Sinatra Dependencies:

If accessing a remote server instead of `localhost`, make sure port 4567 is open
to outside traffic as this service uses port 4567 by default.

When using rvm (Ruby Version Manager), you may need to use `rvmsudo` instead of
`sudo` when running `bundle install`.

```
bundle install
```

- Install Node React Dependencies:
  - See [React Sinatra
    Example](https://github.com/alanbsmith/react-sinatra-example) for more
    development and build informaton.

```
npm install
```

- Update `winner_server` URLs in the code base to the server its running on. In
  future updates this will be handled by config settings.
  - In `app.rb` replace the URL at top of the file with the `winner_server`
    URL.
  - In `webpack.config.js` replace the URL at top of the file with the
    `winner_server`. Note, this is relivant during production when using the
    Webpack Dev server running on port `:8080`.

```ruby
# app.rb
# ...

RPSLS_WINNER_SERVER = 'http://54.70.36.146:4568/api'.freeze
```

```javascript
# webpack.config.js
# ...

devServer: {
  contentBase: "./lib/app/views/",
  hot: true,
  proxy: {
    "/api": "http://54.70.36.146:4567"
  }
},
```

- Start Sinatra App

```
bundle exec ruby app.rb
```

## Setup

### Ruby Version: 2.6.4

You may want to use the [RVM Ruby Version Manager](https://rvm.io/rvm/install)

to install Ruby version 2.6.3.

### Installation

First, install bundler, if you haven't:

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

Retrieve a randomly generated choice (for clients that don't trust the server)

### `GET: /choices`

Get all the choices that are usable for the front-end. Returns JSON array of
possible choices. Note, the choice data originates from the _Winner Service_
micro-service.

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

Play a round of the game (for servers that don’t trust the client)

Example JSON Request body:

```
{
  "player": choice_id
}
```

Example JSON Response body:

```
[
  {
    "choice": "spock",
    "choice_id": 5,
    "name": "player",
    "result": "lose"
  },
  {
    "choice": "lizard",
    "choice_id": 4,
    "name": "computer",
    "result": "win"
  }
]
```

## Credits

### Github Repo: React Sinatra Example

[https://github.com/alanbsmith/react-sinatra-example](https://github.com/alanbsmith/react-sinatra-example)

Starter React setup for implimenting a React Project with Sinatra. Merged the
relative files into the Sinatra app, and made Sinatra config changes in the
`app.rb` file in order to serve static files fromt the React project rather
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

## ToDo

- Try a different structure where the React app is completely separate from the
  Game_Service, and use a proxy on the backend to forward api calls to the
  Game_Game_Service.
- add config setting for webpack.config.js to set the api proxy server and port
