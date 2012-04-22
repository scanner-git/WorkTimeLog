module ApplicationHelper
	def c_c_tag(tag, input=nil, options=nil, &block)
		if !block_given?
			concat(content_tag(tag, input, options)) 
		else
			content = with_output_buffer(&block)
			concat content_tag(tag, input, options){ content }
		end
	end
end
