require './tag.rb'
require './iterator.rb'

class BFS_iterator < Tree_iterator
  private

  def enumerator
    Enumerator.new do |yielder|
      queue = [self.root]
      until queue.empty?
        cur = queue.shift
        yielder << cur
        queue.concat(cur.children) if cur.children
      end
    end
  end
end