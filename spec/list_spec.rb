require 'spec_helper'

RSpec.describe List do
  let!(:list) { List.new('foo') }

  describe 'Initialization' do
    it 'takes a value and creates a head node with it' do
      expect(list.head).to be_a Node
    end

    it 'assigns the passed value to the head node' do
      expect(list.head.value).to eq 'foo'
    end

    it 'assigns the passed value to the tail node' do
      expect(list.tail.value).to eq 'foo'
    end

    it "assigns nil to the node's previous_node" do
      expect(list.head.previous_node).to be_nil
    end

    it "assigns nil to the node's next_node" do
      expect(list.head.next_node).to be_nil
    end
  end

  describe 'Methods' do
    describe '#add' do
      let!(:new_node) { list.add('bar') }

      it "adds a node to the head's next_node" do
        expect(list.head.next_node).to eq new_node
      end

      it "makes the head the new node's previous_node" do
        expect(new_node.previous_node).to eq list.head
      end

      it 'makes the new node the tail' do
        expect(list.tail).to eq new_node
      end

      specify 'the head is not the tail anymore' do
        expect(list.head).not_to eq list.tail
      end

      it "assigns nil to the new_node's next_node" do
        expect(new_node.next_node).to be_nil
      end

      it 'adds a node even if no nodes present' do
        list = List.new('foo')
        list.remove('foo')
        list.add('bar')
        expect(list.head.value).to eq 'bar'
        expect(list.tail.value).to eq 'bar'
      end
    end
  end

  describe '#remove' do
    context 'head must be removed' do
      context 'head is the tail' do
        let(:list) { List.new('foo') }

        it 'assigns nil to the head' do
          list.remove('foo')
          expect(list.head).to be_nil
        end

        it 'assigns nil to the tail' do
          list.remove('foo')
          expect(list.tail).to be_nil
        end
      end

      context 'head is not the tail' do
        let(:list) { List.new('foo') }
        before { list.add('bar') }

        it "assigns the head's next_node as head" do
          list.remove('foo')
          expect(list.head.value).to eq 'bar'
        end

        it "assigns nil to the head's next_node's previous_node" do
          list.remove('foo')
          expect(list.head.previous_node).to be_nil
        end
      end
    end

    context 'tail must be removed' do
      context 'tail is the head' do
        let(:list) { List.new('foo') }

        it 'assigns nil to the head' do
          list.remove('foo')
          expect(list.head).to be_nil
        end

        it 'assigns nil to the tail' do
          list.remove('foo')
          expect(list.tail).to be_nil
        end
      end

      context 'tail is not the head' do
        let(:list) { List.new('foo') }
        before { list.add('bar') }

        it "makes the tail's previous_node the tail" do
          list.remove('bar')
          expect(list.tail.value).to eq 'foo'
        end

        it "assigns nil to the tail's previous_node's next_node" do
          list.remove('bar')
          expect(list.tail.next_node).to be_nil
        end
      end
    end

    context 'anything in between must be removed' do
      let(:list) { List.new('foo') }

      before do
        list.add('bar')
        list.add('foobar')
      end

      it "updates the previous_node's next_node" do
        list.remove('bar')
        expect(list.head.next_node.value).to eq 'foobar'
      end

      it "updates the next_node's previous_node" do
        list.remove('bar')
        expect(list.tail.previous_node.value).to eq 'foo'
      end
    end

    context 'value not found' do
      let(:list) { List.new('foo') }

      it "returns nil" do
        expect(list.remove('not in list')).to be_nil
      end
    end

    describe '#value_at' do
      let(:list) { List.new('foo') }
      before { list.add('bar') }

      it 'returns the value at the index' do
        expect(list.value_at(1)).to eq 'bar'
      end

      it 'return nil if index does not exist' do
        expect(list.value_at(5)).to be_nil
      end
    end
  end
end
