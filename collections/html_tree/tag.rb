class Tag
    attr_accessor :name, :attributes, :children, :content
    
    def initialize(name: "", attributes: {}, children: [], content: "")
        self.name = name
        self.attributes = attributes
        self.children = children
        self.content = content
    end

    #returns a map containing attributes of a tag
    def self.parse_attributes(attributes_str)
        attributes = {}
        attributes_str.scan(/([a-zA-Z]+)="([^" >]*)"/) do |key, value| #every match becomes an element in array
            attributes[key] = value
        end
        return attributes
    end

    def self_closing?
        return self.name.include?("br") || self.name.include?("input")
    end

    def append_child(child)
        self.children << child
    end

    def children_count
        return self.children.length
    end

    #print out an opening html tag
    def open_tag
        attr_list = attributes.map {|key, value| "#{key}=\"#{value}\""}
        tag_str = "<#{self.name} "
        attr_list.each do |tag_attr|
            tag_str += tag_attr + " "
        end
        return tag_str = tag_str[0..-2] + ">"
    end

    def close_tag
        return "</#{self.name}>"
    end

end

# tag_a_str = "<a href=\"https://github.com/SerenityFlaim\", class=\"web-link\">"
# tag_parsed = Tag.parse_attributes(tag_a_str)
# tag_a = Tag.new(name: "a", attributes: tag_parsed)
# print(tag_a.open_tag)