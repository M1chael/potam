require 'spec_helper'
require 'db'

class Test_DB < DB
end

describe DB do
  
  before(:all) do
    @db = Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db")
  end
  
  describe 'DB#initialize' do
    let(:test_data) { [
      { param_int1: 1, param_str1: 'value1', param_int2: 1, param_str2: 'value1' },
      { param_int1: 2, param_str1: 'value2', param_int2: 2, param_str2: 'value2' },
      { param_int1: 3, param_str1: 'value3', param_int2: 3, param_str2: 'value3' },
      { param_int1: 4, param_str1: 'value4', param_int2: 4, param_str2: 'value4' },
      { param_int1: 5, param_str1: 'value5', param_int2: 5, param_str2: 'value5' },
      { param_int1: 6, param_str1: 'value6', param_int2: 6, param_str2: 'value6' },
      { param_int1: 7, param_str1: 'value7', param_int2: 7, param_str2: 'value7' },
      { param_int1: 8, param_str1: 'value8', param_int2: 8, param_str2: 'value8' },
      { param_int1: 9, param_str1: 'value9', param_int2: 9, param_str2: 'value9' },
      { param_int1: 10, param_str1: 'value10', param_int2: 10, param_str2: 'value10' },
      { param_int1: 11, param_str1: 'value11', param_int2: 11, param_str2: 'value11' },
      { param_int1: 12, param_str1: 'value12', param_int2: 12, param_str2: 'value12' },
      { param_int1: 13, param_str1: 'value13', param_int2: 13, param_str2: 'value13' },
    ] }

    it 'should create attr_reader according class name' do
      test = Test_DB.new
      expect(test).to respond_to(:new_test_db_id)
    end
    # it 'should use potam.db by default' do
    #   test = Test_DB.new
    #   expect(test.instance_variable_get(:@db).opts[:database]).to eql('/home/michael/Projects/work/potam/lib/../db/potam.db')
    # end
    # it 'should be able to set specific DB' do
    #   test = Test_DB.new('test')
    #   expect(test.instance_variable_get(:@db)).to eql('test')
    # end
    it 'should connect to table by class name' do
      db = double(@db)
      expect(db).to receive(:[]).with(:test_db)
      test = Test_DB.new(db)
    end

    describe 'DB#create' do
      it 'should save data to table' do
        db_table = double
        test_data.each do |record|
          db = double(@db)
          allow(db).to receive(:[]).with(:test_db) { db_table }
          expect(db_table).to receive(:insert).with(record) { record[:param_int1] }
          test = Test_DB.new(db)
          test.create(record)
          expect(test.new_test_db_id).to eq(record[:param_int1])
        end
      end
    end
  end
end