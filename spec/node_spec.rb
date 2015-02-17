require 'spec_helper'

RSpec.describe Node do
  let!(:previous_node) { Node.new('foo') }
  let!(:next_node) { Node.new('foo') }
  let!(:node) { Node.new('foo', previous_node, next_node) }

  describe 'Initialization' do
    it 'assigns a value' do
      expect(node.value).to eq 'foo'
    end

    it 'assigns nil to the previous_node' do
      expect(node.previous_node).to eq previous_node
    end

    it 'assigns nil to the next_node' do
      expect(node.next_node).to eq next_node
    end

    it 'assigns nil to the next_node by default' do
      expect(previous_node.next_node).to be_nil
    end

    it 'assigns nil to the previous_node by default' do
      expect(previous_node.previous_node).to be_nil
    end
  end
end
