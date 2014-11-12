require 'spec_helper'
require 'tasks'

describe Tasks do
  timestamp = Time.now.to_i
  let(:tasks) { [
        { id: 1, title: 'Тестовая задача 1', description: 'Описание тестовой задачи 1', created_at: timestamp },
        { id: 2, title: 'Тестовая задача 2', description: 'Описание тестовой задачи 2', created_at: timestamp }
      ] }
  describe 'Tasks#create' do
    it 'should save task to DB' do
      db = double(Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
      db_tasks = double
      tasks.each do |task|
        allow(db).to receive(:[]).with(:tasks) { db_tasks }
        expect(db_tasks).to receive(:insert).with(
          title: task[:title], description: task[:description], created_at: task[:created_at])
        test_tasks = Tasks.new(db)
        test_tasks.create(title: task[:title], description: task[:description], created_at: task[:created_at])
      end
    end
  end

  describe 'Tasks#last' do
    it 'should list tasks' do
      FileUtils.cp(CLEANDB, TESTDB)
      db = Sequel.sqlite(TESTDB)
      db_tasks = db[:tasks]
      tasks.each do |task|
        db_tasks.insert(title: task[:title], description: task[:description], created_at: task[:created_at])
      end
      test_tasks = Tasks.new(db)
      expect(test_tasks.last).to eq(tasks.sort{ |x, y| y[:id] <=> x[:id] })
      FileUtils.cp(CLEANDB, TESTDB)
    end
  end
end