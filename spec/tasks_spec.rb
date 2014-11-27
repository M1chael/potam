require 'spec_helper'
require 'tasks'

describe Tasks do
  let(:tasks) { [
        { id: 1, title: 'Тестовая задача 1', description: 'Описание тестовой задачи 1', created_at: 1415812561 },
        { id: 2, title: 'Тестовая задача 2', description: 'Описание тестовой задачи 2', created_at: 1415812566 },
        { id: 3, title: 'Тестовая задача 3', description: 'Описание тестовой задачи 3', created_at: 1415812571 },
        { id: 4, title: 'Тестовая задача 4', description: 'Описание тестовой задачи 4', created_at: 1415812576 },
        { id: 5, title: 'Тестовая задача 5', description: 'Описание тестовой задачи 5', created_at: 1415812581 },
        { id: 6, title: 'Тестовая задача 6', description: 'Описание тестовой задачи 6', created_at: 1415812586 },
        { id: 7, title: 'Тестовая задача 7', description: 'Описание тестовой задачи 7', created_at: 1415812591 },
        { id: 8, title: 'Тестовая задача 8', description: 'Описание тестовой задачи 8', created_at: 1415812596 },
        { id: 9, title: 'Тестовая задача 9', description: 'Описание тестовой задачи 9', created_at: 1415812601 },
        { id: 10, title: 'Тестовая задача 10', description: 'Описание тестовой задачи 10', created_at: 1415812606 },
        { id: 11, title: 'Тестовая задача 11', description: 'Описание тестовой задачи 11', created_at: 1415812611 },
        { id: 12, title: 'Тестовая задача 12', description: 'Описание тестовой задачи 12', created_at: 1415812616 },
        { id: 13, title: 'Тестовая задача 13', description: 'Описание тестовой задачи 13', created_at: 1415812621 }
      ] }

  let(:subtasks) { [
      { id: 1, task_id: 1, title: 'Подзадача 1', status: 0, created_at: 1415812626, finished_at: 0 },
      { id: 2, task_id: 2, title: 'Подзадача 2', status: 1, created_at: 1415812566, finished_at: 1415812631 }
    ] }

  let(:notes) { [
      { id: 1, task_id: 1, text: 'Заметка 1', created_at: 1415812566 },
      { id: 2, task_id: 1, text: 'Заметка 2', created_at: 1415812571 },
      { id: 3, task_id: 3, text: 'Заметка 3', created_at: 1415812961 }
    ] }

  let(:order) { [3, 2, 1] + (4..13).to_a.reverse }

  # let(:db) { double(Sequel.sqlite) }

  # let(:db_table) { double(Sequel::Dataset) }

#   describe 'Tasks#create' do
#     it 'should save task to DB' do
#       db = double(Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
#       db_tasks = double
#       tasks.each do |task|
#         allow(db).to receive(:[]).with(:tasks) { db_tasks }
#         expect(db_tasks).to receive(:insert).with(
#           title: task[:title], description: task[:description], created_at: task[:created_at])
#         test_tasks = Tasks.new(db)
#         test_tasks.create(title: task[:title], description: task[:description], created_at: task[:created_at])
#       end
#     end
#   end

  before(:each) do
    FileUtils.cp(CLEANDB, TESTDB)
    db = Sequel.sqlite(TESTDB)
    # @db_tasks = @db[:tasks]
    {tasks: tasks, subtasks: subtasks, notes: notes}.each do |table_name, data|
      table = db[:"#{table_name}"]
      data.each do |record|
        table.insert(record)
      end
    end
    @test_tasks = Tasks.new(db)
  end

  after(:each) do
    FileUtils.cp(CLEANDB, TESTDB)
  end

  describe '#last' do
    it 'should list 10 last tasks, ordered by time of changes in subtasks or notes' do
      expect(@test_tasks.last).to eq(tasks.sort_by{ |task| order.index(task[:id]) }.first(10))
    end
  end

  describe '#list' do
    it 'should list all tasks, ordered by time of changes in subtasks or notes' do
      expect(@test_tasks.list).to eq(tasks.sort_by{ |task| order.index(task[:id]) })
    end
  end

#   describe 'Tasks#info' do
#     it 'should return info about task' do
#       expect(@test_tasks.info(1)).to eq(tasks[0])
#     end
#   end
end