# frozen_string_literal: truee

RSpec.describe SuperMapper do
  it 'has a version number' do
    expect(SuperMapper::VERSION).not_to be nil
  end

  context '#define_mapping' do
    let(:mapping) { OpenStruct.new }
    before do
      allow(SuperMapper::Mapping).to receive(:new).and_return mapping
    end

    it 'can configure a new mapping' do
      subject.define_mapping OpenStruct do |mapping|
        mapping.one = :eleven
        mapping.two = :twelve
      end

      expect(mapping.one).to eq :eleven
      expect(mapping.two).to eq :twelve
    end
  end

  context '#map' do
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

    before do
      subject.define_mapping First do |mapping|
        mapping.eleven = :one
        mapping.twelve = :two
      end
    end

    let(:first) { First.new 'one', 'two' }
    let(:second) { Second.new }

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
