require 'spec_helper'
require 'tasks'

describe Tasks do
  let(:tasks) { [
        { id: 1, title: 'Тестовая задача 1', description: 'Описание тестовой задачи 1', created_at: 1415791040 },
        { id: 2, title: 'Тестовая задача 2', description: 'Описание тестовой задачи 2', created_at: 1415791041 },
        { id: 3, title: 'Тестовая задача 3', description: 'Описание тестовой задачи 3', created_at: 1415791042 },
        { id: 4, title: 'Тестовая задача 4', description: 'Описание тестовой задачи 4', created_at: 1415791043 },
        { id: 5, title: 'Тестовая задача 5', description: 'Описание тестовой задачи 5', created_at: 1415791044 },
        { id: 6, title: 'Тестовая задача 6', description: 'Описание тестовой задачи 6', created_at: 1415791045 },
        { id: 7, title: 'Тестовая задача 7', description: 'Описание тестовой задачи 7', created_at: 1415791046 },
        { id: 8, title: 'Тестовая задача 8', description: 'Описание тестовой задачи 8', created_at: 1415791047 },
        { id: 9, title: 'Тестовая задача 9', description: 'Описание тестовой задачи 9', created_at: 1415791048 },
        { id: 10, title: 'Тестовая задача 10', description: 'Описание тестовой задачи 10', created_at: 1415791049 },
        { id: 11, title: 'Тестовая задача 11', description: 'Описание тестовой задачи 11', created_at: 1415791050 },
        { id: 12, title: 'Тестовая задача 12', description: 'Описание тестовой задачи 12', created_at: 1415791051 },
        { id: 13, title: 'Тестовая задача 13', description: 'Описание тестовой задачи 13', created_at: 141579104052 },
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

  before(:each) do
    FileUtils.cp(CLEANDB, TESTDB)
    @db = Sequel.sqlite(TESTDB)
    @db_tasks = @db[:tasks]
    tasks.each do |task|
      @db_tasks.insert(title: task[:title], description: task[:description], created_at: task[:created_at])
    end
    @test_tasks = Tasks.new(@db)
  end

  after(:each) do
    FileUtils.cp(CLEANDB, TESTDB)
  end

  describe 'Tasks#last' do
    it 'should list 10 last tasks' do
      expect(@test_tasks.last).to eq(tasks.sort{ |x, y| y[:id] <=> x[:id] }.first(10))
    end
  end

  describe 'Tasks#list' do
    it 'should list all tasks' do
      expect(@test_tasks.list).to eq(tasks.sort{ |x, y| y[:id] <=> x[:id] })
    end
  end

  describe 'Tasks#info' do
    it 'should return info about task' do
      expect(@test_tasks.info(1)).to eq(tasks[0])
    end
  end
end