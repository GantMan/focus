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
    @settings[:focus_group] ||= [] # make sure it's an array
    @settings[:focus_group].unshift(dir.chop) #add with no newline
    @settings[:focus_group].uniq! # once per dir
    save_settings
  end

  def rm_focus dir
    @settings[:focus_group] ||= [] # make sure it's an array
    @settings[:focus_group].delete_if { |d| d == dir.chop } # remove dir
    save_settings
  end

  def clear_groups
    @settings[:focus_group] = [] # clear it out
    save_settings
  end

  def write_limit size
    @settings[:limit] = size.to_i
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