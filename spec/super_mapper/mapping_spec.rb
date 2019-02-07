RSpec.describe SuperMapper::Mapping do
  it 'sets arbitrary values' do
    expect {
      subject.non_existant = :test
      subject.another      = :test
    }.not_to raise_error NoMethodError
  end

  it 'cycles through the saved values' do
    subject.hello = :world

    subject.each do |key, value|
      expect(key).to eq :hello
      expect(value).to eq :world
    end
  end
end