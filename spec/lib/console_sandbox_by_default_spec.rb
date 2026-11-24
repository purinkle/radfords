require "spec_helper"
require_relative "../../lib/console_sandbox_by_default"

describe ConsoleSandboxByDefault do
  def argv_for(*argv, env: { "RAILS_ENV" => "production" })
    described_class.new(argv, env).argv
  end

  it "sandboxes a production console" do
    expect(argv_for("console")).to eq(%w[console --sandbox])
  end

  it "sandboxes the short form too" do
    expect(argv_for("c")).to eq(%w[c --sandbox])
  end

  it "leaves a console that asked for no sandbox alone" do
    expect(argv_for("console", "--no-sandbox")).to eq(%w[console --no-sandbox])
  end

  it "leaves a console that already asked for a sandbox alone" do
    expect(argv_for("console", "-s")).to eq(%w[console -s])
  end

  it "leaves a development console alone" do
    expect(argv_for("console", env: { "RAILS_ENV" => "development" })).to eq(%w[console])
  end

  it "leaves a console with no environment set alone" do
    expect(argv_for("console", env: {})).to eq(%w[console])
  end

  it "leaves other commands alone" do
    expect(argv_for("runner", "puts 1")).to eq(["runner", "puts 1"])
  end

  it "leaves no command alone" do
    expect(argv_for(env: {})).to eq([])
  end

  it "reads the environment from -e" do
    expect(argv_for("console", "-e", "production", env: {})).to eq(%w[console --sandbox -e production])
  end

  it "reads the environment from --environment=" do
    expect(argv_for("console", "--environment=production", env: {}))
      .to eq(%w[console --sandbox --environment=production])
  end

  it "reads a shortened environment name, as Rails does" do
    expect(argv_for("console", "-e", "prod", env: {})).to eq(%w[console --sandbox -e prod])
  end

  it "ignores an environment given as a bare argument, as Rails 6.1 does" do
    expect(argv_for("console", "production", env: {})).to eq(%w[console production])
  end

  it "lets an option override RAILS_ENV" do
    expect(argv_for("console", "-e", "development")).to eq(%w[console -e development])
  end

  it "ignores flags meant for IRB" do
    expect(argv_for("console", "--", "--no-sandbox")).to eq(%w[console --sandbox -- --no-sandbox])
  end
end
