#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__)
require 'bundler'
require 'thor'
require 'lib/focus_filer'

Bundler.require
# Starting point for the Focus script.  Mostly includes the help/thor file documentation and uses
# the FocusFiler object for nitty gritty details.
class Focus < Thor
  default_task :set

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
    focus_filer.write_focus pwd

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
    \x5> $ focus limit 10

  	Setting the limit to zero will allow the focus list to be unbounded.
    \x5> $ focus limit 0
  LONGDESC
  def limit(size)

  end

  desc "show", "shows the local yaml file storage of focus settings"
  long_desc <<-LONGDESC
    `focus show` reads the settings and history file (#{FocusFiler::SETTINGS_FILE}) and outputs the contents to stdout.
  LONGDESC
  def show
    p focus_filer.settings
  end

  private 

  def focus_filer
    @focus_filer ||= FocusFiler.new
  end

end

Focus.start(ARGV)
