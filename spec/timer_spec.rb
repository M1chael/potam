require 'timer'

class Test
  include Timer
end

describe Timer do
  let(:test) { Test.new }
  let(:now) { 1415942161 }
  let(:last_mon) { 1415559600 }

  around(:example) do |example|
    ENV['POTAMTIME'] = now.to_s
    ENV['POTAM'] = 'test'
    example.run
    ENV['POTAM'] = 'production'
  end

  describe '#now' do
    it 'should return test timestamp' do
      expect(test.now).to eq(now)
    end
  end

  describe '#last_mon' do
    it 'should return last mondau 00:00:00 timestamp' do
      expect(test.last_mon).to eq(last_mon)
    end
  end

end