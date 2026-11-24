# Rails 7.2 adds config.sandbox_by_default, which opens a production console
# in sandbox mode, so every change rolls back on exit unless it was asked for
# with --no-sandbox. Rails 6.1 gives its --sandbox flag a default of false, so
# by the time the app loads it can no longer tell "no flag" from
# "--no-sandbox". bin/rails runs this on its arguments first instead.
#
# Delete this file and its call in bin/rails once Rails is 7.2 or later, and
# set config.sandbox_by_default in config/environments/production.rb.
class ConsoleSandboxByDefault
  COMMANDS = %w[console c].freeze
  SANDBOX_FLAGS = %w[--sandbox -s --no-sandbox].freeze

  def initialize(argv, env)
    @command, *@rest = argv
    @env = env
  end

  # The arguments to run, with --sandbox added to a production console that
  # did not choose for itself.
  def argv
    return [command, *rest].compact unless sandbox_by_default?

    [command, "--sandbox", *rest]
  end

  private

  attr_reader :command, :env, :rest

  def sandbox_by_default?
    COMMANDS.include?(command) && !rails_arguments.intersect?(SANDBOX_FLAGS) && environment == "production"
  end

  # Anything after "--" belongs to IRB, not to Rails.
  def rails_arguments
    rest.take_while { |argument| argument != "--" }
  end

  def environment
    environment_option || rails_arguments.find { |argument| !argument.start_with?("-") } ||
      env["RAILS_ENV"] || env["RACK_ENV"]
  end

  # -e production, -eproduction, --environment production or
  # --environment=production.
  def environment_option
    rails_arguments.join(" ")[/(?:\A|\s)(?:-e\s*|--environment[=\s])(\S+)/, 1]
  end
end
