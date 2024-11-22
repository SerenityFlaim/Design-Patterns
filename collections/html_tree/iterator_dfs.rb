require './tag.rb'
require './iterator.rb'

class DFS_iterator < Tree_iterator
  private

  def enumerator
    Enumerator.new do |yielder|
      stack = [self.root]
      until stack.empty?
        cur = stack.pop
        yielder << cur
        stack.concat(cur.children.reverse) if cur.children
      end
    end
  end
end