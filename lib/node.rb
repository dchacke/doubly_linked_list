class Node
  attr_reader :value
  attr_accessor :previous_node, :next_node

  def initialize(value, previous_node = nil, next_node = nil)
    @value = value
    @previous_node = previous_node
    @next_node = next_node
  end
end
