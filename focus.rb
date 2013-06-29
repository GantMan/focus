require "bundler"
require "thor"
require "pathname"
require "fileutils"
Bundler.require

class Focus < Thor

	desc "set", "sets the current directory as the latest in directory in your focus group"
	long_desc <<-LONGDESC
    `focus set` will add the present working directory as the latest directory and primary focus path.
 
    You can optionally specify any directory other than the current using the `dir` option.
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
  def clear

  end

  desc "limit", "sets the maximum amount of focuses you store before deletion begins"
  def limit

  end

  default_task :set
end

Focus.start(ARGV)
