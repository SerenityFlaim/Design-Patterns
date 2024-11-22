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
        attr_values = attributes_str.scan(/([a-zA-Z]+)="([^" >]*)"/)
        attributes_str.scan(/([a-zA-Z]+)="([^" >]*)"/) do |key, value| #every match becomes an element in array
            attributes[key] = value
        end
        return attributes
    end

    def self.self_closing?(tag_text)
        name = tag_text.split(/\s+/, 2)[0]
        return name.include?("br") || name.include?("input")
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

    #print out closing html tag
    def close_tag
        return "</#{self.name}>"
    end

end