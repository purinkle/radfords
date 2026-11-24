if Rails.env.local?
  require "bundler/audit/task"
  Bundler::Audit::Task.new
end
