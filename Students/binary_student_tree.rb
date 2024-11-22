require "./student.rb"

class TreeNode
    attr_accessor :data, :left, :right

    def initialize(data)
        self.data = data
        self.left = nil
        self.right = nil
    end
end

class StudentTree
    include Enumerable
    attr_reader :root

    def initialize
        self.root = nil
    end

    def append(data)
        if root.nil?
            self.root = TreeNode.new(data)
        else
            append_node(self.root, data)
        end
    end

    private def append_node(prev_node, data)
        if data > prev_node.data
            if prev_node.right == nil
                prev_node.right = TreeNode.new(data)
            else
                append_node(prev_node.right, data)
            end
        else
            if prev_node.left == nil
                prev_node.left = TreeNode.new(data)
            else
                append_node(prev_node.left, data)
            end
        end
    end

    #print binary tree in-order
    def print_tree(cur_node = self.root)
        return if cur_node.nil?
        print_tree(cur_node.left)
        puts (cur_node.data)
        print_tree(cur_node.right)
    end

    def each(&block)
        traverse_tree(self.root, &block)
    end

    #traverse binary tree in-order
    private def traverse_tree(cur_node, &block)
        return if cur_node.nil?
        traverse_tree(cur_node.left, &block)
        yield cur_node.data
        traverse_tree(cur_node.right, &block)
    end

    private
    attr_writer :root
end