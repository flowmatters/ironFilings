

def nice_methods(obj,matching=/.*/)
	obj.methods.each do |m|
		if m.match matching
			puts m
		end
	end
	nil
end