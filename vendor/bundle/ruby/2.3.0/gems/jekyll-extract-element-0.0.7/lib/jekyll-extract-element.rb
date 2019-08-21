require 'nokogiri'

module JekyllExtractElement
	def extract_element(html, element)
		entries = []
		@doc = Nokogiri::HTML::DocumentFragment.parse(html)

		@doc.css(element).each do |node|
			entries << {
				"text" => node.text,
				"node_name" => node.name,
				"id" => node.attr("id")
			}
		end

		entries
	end
end

Liquid::Template.register_filter(JekyllExtractElement)