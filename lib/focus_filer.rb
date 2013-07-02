require "pathname"
require "fileutils"

class FocusFiler
  attr_accessor :settings

  # Settings file per user
  SETTINGS_FILE = "~/.focus.yml"

  def initialize
    p "Here I AM!"
    @settings = YAML::load_file SETTINGS if File.exists?(SETTINGS_FILE)
  end

  # Save the settings as they exist now
  def save_settings
    File.open(SETTINGS_FILE, "w") do |file|
      file.write @settings.to_yaml
    end
  end


  def settings
    @settings || "No settings have been stored on this system yet."
  end
end