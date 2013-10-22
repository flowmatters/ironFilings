 
project_fn = ARGV[0]
output_fn = ARGV[1]

require 'source_access'
require 'functions'

def fn_safe_name(unsafe_name)
	unsafe_name.gsub(" ","_").gsub("#","")
end

def add_fu_area_functions(scenario)
	network = scenario.network
	fm = network.function_manager

	network.catchments.each do |c|
		cname = fn_safe_name(c.name)
		c.functional_units.each do |fu|
			fu_name = fn_safe_name(fu.definition.name)

			fn_name_prefix = cname + "__" + fu_name
			puts "Creating " + fn_name_prefix
			fm.functions.add create_function_for_parameter(fu,"areaInSquareMeters",fn_name_prefix)
		end
	end
end

p = load_project(project_fn)
scenario = p.get_scenarios[0].scenario

add_fu_area_functions(scenario)

save_project(p,output_fn)