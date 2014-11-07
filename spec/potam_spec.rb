require 'spec_helper'

describe Potam do
  # before(:all) do
  #   @db_path = './test/clean.db'
  # end
  before(:each) do
    # Sequel::Model.db.tables.each do |table|
    #   Sequel::Model.db[table].delete
    # end
    allow(SQLite).to receive(:new)
    potam = Potam.new(db: @db_path)
  end
  describe 'Add task to DB' do
    it 'should load SQLite DB' do
      expect(SQLite).to have_received(:new).with(@db_path)
    end
  end
end