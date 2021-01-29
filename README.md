# High level overview

We have created a simple application that comprises a backend app built in Ruby on Rails (API mode), and a separate frontend application bootstrapped with Create React App.

The purpose of the app is to create shortened versions of URLs. For example, given the url `https://google.com`, the backend application would create a shortcode such as `41e515a91a72`.

The Rails application has three endpoints, detailed below:

```
GET /urls # Returns all shortcodes
POST /urls # Create a new short url. Parameters: url:string
GET /urls/:id # Redirect to the long version of a short url
```

# Docker setup

```
> docker-compose run --rm backend
```

This will start backend, frontend and redis. The website is available under https://localhost:3001
and you can update and add files in your local filesystem which will automatically get synced.

## Running rspec tests

```
> docker-compose run --rm bundle exec rspec spec
```


# Backend setup

There is no database portion to the backend application. The only store we require is Redis. Therefore, you will need to install `redis-server`.

On OS X, you can install this through Homebrew by running:

```
brew install redis
brew services start redis
```

The setup commands are:

```
cd backend
bundle install
bundle exec rails s
```

# Frontend setup

```
cd frontend
yarn install
yarn start
```

The frontend application should automatically open in the browser.

# Ports

Backend default port: `3000`

Frontend default port: `3001`