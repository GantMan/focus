require 'pathname'
require 'fileutils'
require 'yaml'

class FocusFiler
  attr_accessor :settings

  # Settings file per user
  SETTINGS_FILE = "focus.yml"

  def initialize
    if File.exists?(SETTINGS_FILE)
      @settings = YAML::load_file SETTINGS_FILE
    else
      @settings = {}
    end
    
  end

  def settings
    @settings || "No settings have been stored on this system yet."
  end

  def write_focus dir
    @settings[:focus_group] ||= []
    @settings[:focus_group].unshift(dir.chop)
    @settings[:focus_group].uniq!
    p @settings
    save_settings
  end

  private

  # Save the settings as they exist now
  def save_settings
    File.open(SETTINGS_FILE, File::WRONLY|File::CREAT) do |file|
      file.write @settings.to_yaml
    end
  end

end