require './tag.rb'
require './tree.rb'

html_string = 
"<html>
    <body>
        <h2>Example page</h2>
        <div>
            <a href=\"https://github.com/SerenityFlaim\", class=\"web-link\">
                link
            </a>
            <div class=\"veg_container\"></div>
            <ol>
                <li>tomato</li>
                <li>cucumber</li>
                <li>carrot</li>
            </ol>
        </div>
        <div>
            <input type=\"text\">
            <br>
            <br>
            <br>
            <input type=\"text\">
        </div>
        <div>
            <div>
                <p>light</p>
                <p>restoration</p>
                <div>serenity</div>
            </div>
        </div>
        <br>
        <span>the end.</span>
    </body>
</html>"

html_tree = Tree.new(html_string)

puts(html_tree.count)
div_elements = html_tree.select {|node| node.name == "div" }
input_elements = html_tree.find_all {|node| node.name == "input"}
attribute_element = html_tree.find {|node| node.content != ""}

puts(attribute_element.content)
div_elements.each {|node| puts(node.name)}
input_elements.each {|node| puts(node.name)}


def print_html_dfs(html_tree)
  iterator = html_tree.dfs_iterator
  parents = []

  iterator.each do |node|
    structure = ""

    if !Tag.self_closing?(node.name) && node.children_count > 0
      parents.push [node, node.children_count]
    end

    structure += "#{node.open_tag}#{node.content}"

    if !Tag.self_closing?(node.name) && node.children_count == 0
      structure += "#{node.close_tag}"
    end

    puts structure

    while parents.any? && parents.last[1] == 1 && node != parents.last[0]
      parent = parents.pop[0]
      puts "#{parent.close_tag}"
    end

    parents.last[1] -= 1 if parents.any? && node != parents.last[0]
  end

  parents.reverse.each do |parent, _|
    puts "#{parent.close_tag}"
  end
end

def print_open_tags_bfs(html_tree)
  iterator = html_tree.bfs_iterator
  iterator.each { |node| puts node.open_tag}
end

# puts "HTML"
# print_html_dfs(html_tree)

# puts "\nIncomplete BFS HTML:"
# print_open_tags_bfs(html_tree)

