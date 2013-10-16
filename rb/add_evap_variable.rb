
# Optionally specify Source version by uncommenting the next line
# ENV["IRON_FILINGS_SOURCE"] = "C:\\Program Files\\eWater\\Source 3.5.0.646"
# (Otherwise, the default will be 3.4.3.540)
require 'source_access'

include RiverSystem::Functions
include TIME::Tools::Reflection

p = load_project("..\\sample_data\\YieldExample.rsproj")
scenario = p.get_scenarios[0].scenario
network = scenario.network

storage_node = network.node_with_name 'Storage'  # The node (the location)
storage = storage_node.node_models[0]            # The model attached to the node

# Obtain a reference to the Evaporation (mm/day) variable in the storage
ri = ReflectedItem.new_item("EvaporationInMillimetresPerDay",storage)

# Create a new function
newfn = Function.new
newfn.name="$storage_evap"

# Set the expression to be a simple value --
# the existing value of the variable we want to control
newfn.expression = ri.itemValue.to_s

# And add to the function manager
network.function_manager.functions.add newfn

# Create a 'usage', so that the fullSupplyLevel is overidden by the value of the function
newfn_usage = FunctionUsage.new
newfn_usage.reflected_item = ri
newfn.usages.add newfn_usage

# And save...
save_project(p,"..\\sample_data\\YieldExampleWithEvapFunction.rsproj")
