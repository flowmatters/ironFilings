#
# Upgrade all Source projects is a given directory to a specified version of Source
#

unless [3,4].include? ARGV.length
	puts "Usage: "
	puts "  ir64 upgrade_directory.rb <input_dir> <dest_dir> <source_path> [-f]"
	puts ""
	puts "Notes: "
	puts " * Any paths containing spaces (eg C:\\Program Files) should be surrounded by quotes"
	puts " * -f will force overwriting of existing files in the destination directory. Otherwise skipped"
	puts ""
	puts "Written by Joel Rahman (joel@flowmatters.com.au)"
	puts "Part of IronFilings"
	exit
end

input_dir = ARGV[0]
output_dir = ARGV[1]
source_path = ARGV[2]
force_override = ARGV[3] == "-f"

ENV["IRON_FILINGS_SOURCE"] = source_path

require 'source_access'

Dir.mkdir output_dir unless Dir.exist?(output_dir)

puts "Upgrading files from #{input_dir} to #{output_dir}"
Dir.new(input_dir).each do |proj_file|
	if proj_file.match /rsproj$/
		source_file = input_dir + "\\" + proj_file
		dest_file = output_dir + "\\" + proj_file
		if File.exist?(dest_file) and not force_override
			puts "Skipping " + proj_file + ". File with that name already exists in " + output_dir
		else
			puts "Upgrading " + proj_file
			p = load_project(source_file)
			save_project(p,dest_file)
		end
	end
end
