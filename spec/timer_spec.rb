require 'timer'

class Test
  include Timer
end

describe Timer do
  let(:test) { Test.new }
  let(:time) { 1415942161 }

  describe '#now' do

    around(:example) do |example|
      ENV['POTAMTIME'] = time.to_s
      ENV['POTAM'] = 'test'
      example.run
      ENV['POTAM'] = 'production'
    end

    it 'should return test timestamp' do
      expect(test.now).to eq(time)
    end
  end
end