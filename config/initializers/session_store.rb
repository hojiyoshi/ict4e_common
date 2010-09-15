# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ict4e_common_session',
  :secret      => '0e63b70e847d993d1c8a31980baccee3309c4ef517aa276653a681949a3b3538731cbdf886688538a387e94aeaad345e352f169b2b725bcc6f469486a41b229b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
