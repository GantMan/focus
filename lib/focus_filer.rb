require 'pathname'
require 'fileutils'
require 'yaml'

class FocusFiler
  attr_accessor :settings

  # Settings file per user
  SETTINGS_FILE = Dir.home + "/.focus.yml"

  def initialize
    # initialize from file and defaults
    @settings = YAML::load_file SETTINGS_FILE if File.exists?(SETTINGS_FILE)
    @settings ||= {} # default to hash
    @settings[:focus_group] ||= [] # default to array
    @settings[:limit] ||= 0 # default to infite size 
  end

  def settings
    @settings
  end

  def write_focus dir
    @settings[:focus_group].unshift(dir.strip) #add to front with no newline
    @settings[:focus_group].uniq! # once per dir
    @settings[:focus_group] = resize_focus(@settings[:limit]) # incase we have a limit
    save_settings
  end

  def rm_focus dir
    @settings[:focus_group] ||= [] # make sure it's an array
    @settings[:focus_group].delete_if { |d| d == dir.strip } # remove dir
    save_settings
  end

  def clear_groups
    @settings[:focus_group].clear
    save_settings
  end

  def write_limit size
    @settings[:limit] = size.strip.to_i
    @settings[:focus_group] = resize_focus(@settings[:limit])
    save_settings
  end

  def next dir
    false
  end

  private

  # if the limit is being used (i.e. >0), we need to cut trailing off 
  def resize_focus(limit)
    if limit && limit > 0
      #using shift over slice here bc index may be out of range
      @settings[:focus_group].shift(limit)
    else
      @settings[:focus_group]
    end
  end

  # Save the settings as they exist now
  def save_settings
    File.open(SETTINGS_FILE, File::TRUNC|File::WRONLY|File::CREAT) do |file|
      file.write @settings.to_yaml
    end
  end

end