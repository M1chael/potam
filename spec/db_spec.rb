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
  end
end