require 'output'
class Logger
	def initialize(mode)
		if mode=="production"
			@output_file=Output.file '/log/production.log'
		else
			@output_file=Output.file '/log/test.log'
		end
	end

	#Append the given line to the correct file
	def log(line)
		file=File.open(@output_file,"a+")
		file.puts(line)
		file.close
	end

end
