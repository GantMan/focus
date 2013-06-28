require "thor"

class Focus < Thor

	desc "set", "sets the current working directory as the latest in directory in your focus group"
	def set
		puts "I worked!"
	end
end

Focus.start(ARGV)