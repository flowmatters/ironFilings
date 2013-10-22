
include RiverSystem::Functions
include TIME::Tools::Reflection

def create_function_for_parameter(object,parameter_name,function_prefix)
	fn_name = "$" + function_prefix + "_" + parameter_name
	ri = ReflectedItem.new_item(parameter_name,object)

	newfn = Function.new
	newfn.name=fn_name

	# Set the expression to be a simple value --
	# the existing value of the variable we want to control
	newfn.expression = ri.itemValue.to_s

	# Create a 'usage', so that the fullSupplyLevel is overidden by the value of the function
	newfn_usage = FunctionUsage.new
	newfn_usage.reflected_item = ri
	newfn.usages.add newfn_usage

	newfn
end