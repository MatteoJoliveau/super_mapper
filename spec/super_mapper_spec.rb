# frozen_string_literal: true
class First
  attr_accessor :one, :two

  def initialize one, two
    @one = one
    @two = two
  end
end

class Second
  attr_accessor :eleven, :twelve
end

RSpec.describe SuperMapper do
  let(:first) { First.new 'one', 'two' }
  let(:second) { Second.new }

  it 'has a version number' do
    expect(SuperMapper::VERSION).not_to be nil
  end

  context '.new' do
    it 'acccepts a tap block' do
      mapper = described_class.new do |mapper|
        expect(mapper).to be_an_instance_of SuperMapper

        mapper.define_mapping First, Second do |first, second|
          second.eleven = first.one
        end
      end

      second = mapper.map first, Second
      expect(second.eleven).to eq first.one
    end
  end

  context '#define_mapping' do
    it 'can configure a new mapping' do
      subject.define_mapping First, Second do |first, second|
        second.eleven = first.one
        second.twelve = first.two
      end

      mapping = subject.instance_variable_get(:'@mapping_registry')['First-Second']
      expect(mapping).not_to be_nil
      expect(mapping).to respond_to :call
    end
  end

  context '#map' do
    before do
      subject.define_mapping First, Second do |first, second|
        second.eleven = first.one
        second.twelve = first.two
      end
    end

    it 'can convert between one object and a class' do
      expect(second.eleven).to be_nil
      expect(second.twelve).to be_nil
      result = subject.map first, second
      expect(result).to be second
      expect(result.eleven).to eq first.one
      expect(result.twelve).to eq first.two
    end

    it 'can convert between two objects' do
      result = subject.map first, Second
      expect(result).to be_an_instance_of Second
      expect(result.eleven).to eq first.one
      expect(result.twelve).to eq first.two
    end
  end
end
