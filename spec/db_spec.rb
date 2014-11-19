require 'spec_helper'
require 'db'

class Test_DB < DB

end

describe DB do
  describe 'DB#initialize' do
    it 'should create addr_reader according class name' do
      test = Test_DB.new
      expect(test).to respond_to(:new_test_db_id)
    end
    it 'should use potam.db by default' do
      test = Test_DB.new
      expect(test.instance_variable_get(:@db).opts[:database]).to eql('/home/michael/Projects/work/potam/lib/../db/potam.db')
    end
    it 'should be able to set specific DB' do
      test = Test_DB.new('test')
      expect(test.instance_variable_get(:@db)).to eql('test')
    end
  end
end