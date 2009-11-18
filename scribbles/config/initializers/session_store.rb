# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scribbles_session',
  :secret      => '4ff7ae483e7553bbcaa000d6ae7864344e6e763aa8a688af2afc617a06afd47704419137f286abea96fab86434602fe18da3cc1f8eb39372457f785312f23832'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
