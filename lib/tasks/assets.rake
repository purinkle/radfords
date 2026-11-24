# Rails 6.1 installed the JavaScript packages before precompiling assets, and
# Webpacker's build relies on that. Rails 7.0 stopped doing it, so a fresh
# checkout, such as a CI container, precompiled with no node_modules and
# failed on "webpack not found". Put the step back.
#
# Delete this once the app leaves Webpacker, whose replacement installs its
# own packages (issue 610).
Rake::Task["assets:precompile"].enhance(["yarn:install"]) if Rake::Task.task_defined?("assets:precompile")
