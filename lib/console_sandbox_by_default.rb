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
  # -e production, -eproduction, --environment production or
  # --environment=production.
  ENVIRONMENT_OPTION = /(?:\A|\s)(?:-e\s*|--environment[=\s])(\S+)/

  def initialize(argv, env)
    @argv = argv
    @env = env
  end

  # The arguments to run, with --sandbox added to a production console that
  # did not choose for itself.
  def argv
    return @argv unless sandbox_by_default?

    command, *rest = @argv
    [command, "--sandbox", *rest]
  end

  private

  def sandbox_by_default?
    COMMANDS.include?(@argv.first) && !rails_arguments.intersect?(SANDBOX_FLAGS) && production?
  end

  # Anything after "--" belongs to IRB, not to Rails.
  def rails_arguments
    @argv.drop(1).take_while { |argument| argument != "--" }
  end

  # Rails reads the environment from -e, then RAILS_ENV, then RACK_ENV, and
  # takes any leading part of a name, so -e prod is production too.
  def production?
    environment = rails_arguments.join(" ")[ENVIRONMENT_OPTION, 1] || @env["RAILS_ENV"] || @env["RACK_ENV"]
    !environment.to_s.empty? && "production".start_with?(environment)
  end
end
