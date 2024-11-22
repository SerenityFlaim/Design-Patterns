require './tag.rb'
require './iterator_dfs.rb'
require './iterator_bfs.rb'

class Tree
    attr_accessor :root, :stack

    def initialize(html_string)
        self.stack = []
        self.root = self.parse_html(html_string)
    end

    def dfs_iterator
        return DFS_iterator.new(self.root)
    end

    def bfs_iterator
        return BFS_iterator.new(self.root)
    end

    private
    def parse_html(html_string)
        cur_parent = nil
        html_nodes = html_string.scan(/<[^>]+>|[^<]+/)
        html_string.scan(/<[^>]+>|[^<]+/) do |cur_el|
            cur_el.strip!
            if cur_el.start_with?("<")
                if cur_el.start_with?("</")
                    process_close_tag(cur_el)
                    cur_parent = self.stack.last
                elsif Tag.self_closing?(cur_el)
                    process_self_closing_tag(cur_el, cur_parent)
                else
                    cur_parent = process_open_tag(cur_el, cur_parent)
                end
            elsif !cur_el.empty?
                populate_content(cur_el, cur_parent)
            end
        end

        return self.root
    end

    def process_open_tag(cur_tag, cur_parent)
        tag_text = cur_tag[1..-2]
        name, attributes = tag_text.split(/\s+/, 2)
        attributes = attributes.nil? ? {} : Tag.parse_attributes(attributes)
        tag = Tag.new(name: name, attributes: attributes)

        if (cur_parent)
            cur_parent.append_child(tag)
        else
            self.root = tag
        end
        self.stack << tag
        return tag
    end

    def process_close_tag(cur_tag)
        name = cur_tag[2..-2]
        if self.stack.last.name == name 
            stack.pop
        end
    end

    def process_self_closing_tag(cur_tag, cur_parent)
        tag_text = cur_tag[1..-2]
        name, attributes = tag_text.split(/\s/, 2)
        attributes = attributes.nil? ? {} : Tag.parse_attributes(attributes)
        tag = Tag.new(name: name, attributes: attributes)
        
        if(cur_parent)
            cur_parent.append_child(tag)
        end
        #We don't return new parent because tag self closed and parent remained the same
    end
        
    def populate_content(cur_text, cur_parent)
        cur_parent.content += cur_text if cur_parent
    end

end