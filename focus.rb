require "bundler"
require "thor"
require "pathname"
require "fileutils"
Bundler.require

class Focus < Thor
  # Settings file per user
  SETTINGS = "~/.focus.yml"

  no_commands do
    @settings = YAML::load_file SETTINGS if File.exists?(SETTINGS)


    # Save the settings as they exist now
    def save_settings
      File.open(SETTINGS, "w") do |file|
        file.write @settings.to_yaml
      end
    end
  end

	desc "set", "sets the current directory as the latest in directory in your focus group"
	long_desc <<-LONGDESC
    `focus set` will add the present working directory as the latest directory and primary focus path.
 
    You can optionally specify any directory other than the current working directy by using the `dir` option.
    \x5> $ focus set
    \x5> $ focus set --dir=~/Projects
  LONGDESC
	option :dir
	def set
		# get the present working directory (requested)
		pwd = options[:dir] || `pwd`
		puts "pwd gave back #{pwd}"

	end


  desc "clear", "clears all focuses from the focus group"
  long_desc <<-LONGDESC
  	`focus clear` will remove all directories stored. 
  LONGDESC
  def clear

  end

  desc "limit", "sets the maximum amount of focuses you store before deletion begins"
  long_desc <<-LONGDESC
  	`focus limit` sets the maximum size of the focus list.  Whent he limit is reached the oldest entry will be deleted.

  	Setting the limit to zero will allow the focus list to be unbounded.
  LONGDESC
  def limit(size)

  end

  desc "show", "shows the local yaml file storage of focus settings"
  long_desc <<-LONGDESC
    `focus show` reads the settings and history file (#{SETTINGS}) and outputs the contents to stdout.
  LONGDESC
  def show
    p @settings || "No settings have been stored on this system yet."
  end

  default_task :set
end

Focus.start(ARGV)
