class List
  attr_reader :head, :tail

  def initialize(value)
    @head = Node.new(value)
    @tail = @head
  end

  def add(value)
    node = Node.new(value, @tail)

    if @tail
      @tail.next_node = node
      @tail = @tail.next_node
    else
      @head = node
      @tail = node
    end
  end

  def remove(value)
    # Traverse the list to find node with given value
    current = @head

    until current.value == value || current.next_node.nil?
      current = current.next_node
    end

    # If no node with given value found, return nil
    return nil if current.value != value

    # If the current node is the head
    if current == @head
      # If the head has a next node, make that one the head
      # and set its previous_node to nil
      if @head.next_node
        @head = @head.next_node
        @head.previous_node = nil
      # If the head does not have a next node, just set it
      # to nil; this also means that the head was the tail,
      # so set the tail to nil as well
      else
        @head = nil
        @tail = nil
      end
    # If the current node is the tail
    elsif current == @tail
      # Set the tail's previous_node as tail
      @tail = @tail.previous_node

      # Set the tail's next_node to nil
      @tail.next_node = nil
    # If the current node is somewhere in the middle
    else
      # Set the current node's previous_node's next_node to the current node's next_node
      current.previous_node.next_node = current.next_node

      # Set the current node's next_node's previous_node to the current node's previous node
      current.next_node.previous_node = current.previous_node
    end
  end

  def value_at(index)
    # If there is at least one item, search
    if @head
      # Traverse the tree and stop once index reached
      current = @head
      counter = 0

      until !current.next_node || index == counter
        current = current.next_node
        counter += 1
      end

      # If there were not enough next nodes to go
      # all the way up to the index, return nil
      return nil if counter < index

      # At this point, the node with the specified
      # value has been found and should be returned
      current.value
    end
  end
end
