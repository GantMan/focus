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
    @settings[:focus_group].unshift(dir.chop) #add to front with no newline
    @settings[:focus_group].uniq! # once per dir
    @settings[:focus_group] = resize_focus(@settings[:limit]) # incase we have a limit
    save_settings
  end

  def rm_focus dir
    @settings[:focus_group] ||= [] # make sure it's an array
    @settings[:focus_group].delete_if { |d| d == dir.chop } # remove dir
    save_settings
  end

  def clear_groups
    @settings[:focus_group].clear
    save_settings
  end

  def write_limit size
    @settings[:limit] = size.to_i
    save_settings
  end

  private

  # if the limit is being used (i.e. >0), we need to cut trailing off 
  def resize_focus(limit)
    if limit && limit > 0
      #using shift over slice here bc index may be out of range
      @settings[:focus_group].shift(limit)
    end
  end

  # Save the settings as they exist now
  def save_settings
    File.open(SETTINGS_FILE, File::WRONLY|File::CREAT) do |file|
      file.write @settings.to_yaml
    end
  end

end