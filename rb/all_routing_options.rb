
unless  [1,2].include? ARGV.length
	puts "Usage"
	puts "ir64 all_routing_options.rb <project_file> [path_to_source]"
	exit
end

ENV["IRON_FILINGS_SOURCE"] = ARGV[1] if ARGV.length == 2
require 'source_access'

include RiverSystem
include RiverSystem::Flow

project_fn = ARGV[0]
basename = project_fn.gsub ".rsproj", ""

project = load_project(project_fn)
scenario = project.get_scenarios[0].scenario
network = scenario.network

routing_types = [StraightThroughRouting, 
	             LaggedFlowRoutingWrapper,
                 StorageRouting]

routing_types.each do |rt|
	routing_name = rt.to_s.split("::")[-1]
	puts "Setting all links to " + routing_name
	network.get_i_links.each do |link|
		link.flow_routing = rt.new
	end

	new_fn = basename + "_" + routing_name + ".rsproj"
	save_project(project,new_fn)
end


