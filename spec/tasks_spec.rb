# require 'spec_helper'
require 'tasks'

describe Tasks do
  # before(:all) do
  #   @db_path = './test/clean.db'
  # end
  # before(:each) do
    # Sequel::Model.db.tables.each do |table|
    #   Sequel::Model.db[table].delete
    # end
  #   allow(SQLite).to receive(:new)
  #   potam = Potam.new(db: @db_path)
  # end
  describe 'Tasks#create' do
    it 'should save task to DB' do
      tasks = [
        {title: 'Тестовая задача 1', description: 'Описание тестовой задачи 1'},
        {title: 'Тестовая задача 2', description: 'Описание тестовой задачи 2'}
      ]
      db = double(Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
      db_tasks = double
      tasks.each do |task|
        # allow(db).to receive(:insert).with(title: task[:title], description: task[:description])
        allow(db).to receive(:[]).with(:tasks) { db_tasks }
        expect(db_tasks).to receive(:insert).with(title: task[:title], description: task[:description])
        test_tasks = Tasks.new(db)
        test_tasks.create(title: task[:title], description: task[:description])
      end
      # expect(SQLite).to have_received(:new).with(@db_path)
    end
  end
end