# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks
task(:default).clear
task default: [:spec]

if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
end

# PROTOTYPE (issue #580 question 3). Webpacker compiled on demand and keyed the
# Stripe stub entry on RAILS_ENV, so the suite never had to ask for a build.
# jsbundling builds ahead of time, so the spec task has to ask, and it has to
# ask in the test environment or the stub entry is left out.
task :build_javascript_for_test do
  sh({ "RAILS_ENV" => "test" }, "yarn build")
end

task(:default).clear
task default: %i[build_javascript_for_test spec]
