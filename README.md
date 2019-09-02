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
