Airbrake.configure do |config|
  config.project_key = ENV["AIRBRAKE_API_KEY"]
  config.project_id = ENV["AIRBRAKE_PROJECT_ID"]
end
