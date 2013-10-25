

def nice_methods(obj,matching=/.*/)
	obj.methods.each do |m|
		if m.match matching
			puts m
		end
	end
	nil
end

def get_info(obj,method_name,ruby_name=true)
	c = obj.GetType
	if ruby_name
		c.get_member(IronRuby::Clr::Name.unmangle(method_name))
	else
		c.get_member(method_name)
	end
end