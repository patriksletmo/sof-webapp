# Configuration for the external database server
Rails.application.config.database_api_url = ENV.fetch('API_BASE_URL') {'https://api.sof17.se'}
