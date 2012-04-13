module ApplicationHelper
	def c_c_tag(tag, input=nil, &block)
		if !block_given?
			concat(content_tag(tag, input)) 
		else
			content = with_output_buffer(&block)
			concat content_tag(tag){ content }
		end
	end
end
