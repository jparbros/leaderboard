# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_leaderboard_session', domain: {
  production: '.herokuapp.com',
  development: '.lvh.me'
}.fetch(Rails.env.to_sym, :all)
