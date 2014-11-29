require 'spec_helper'
require 'report'

describe Report do
  # Ср. нояб.  5 10:16:01
  # Ср. нояб.  5 13:13:01
  # Ср. нояб. 12 22:16:06
  let(:tasks) { [
      { id: 1, title: 'Тестовая задача 1', description: 'Описание тестовой задачи 1', created_at: 1415164561 },
      { id: 2, title: 'Тестовая задача 2', description: 'Описание тестовой задачи 2', created_at: 1415175181 },
      { id: 3, title: 'Тестовая задача 3', description: 'Описание тестовой задачи 3', created_at: 1415812566 }
    ] }
  # Ср. нояб.  5 17:00:25
  # Чт. нояб.  6 10:13:21, Пн. нояб. 10 09:10:21
  # Чт. нояб. 13 11:00:01
  let(:subtasks) { [
      { id: 1, task_id: 1, title: 'Подзадача 1', status: 0, created_at: 1415188825, finished_at: 0 },
      { id: 2, task_id: 2, title: 'Подзадача 2', status: 1, created_at: 1415250801, finished_at: 1415592621 },
      { id: 3, task_id: 3, title: 'Подзадача 3', status: 0, created_at: 1415858401, finished_at: 0 }
    ] }
  # Пт. нояб.  7 10:10:23
  # Вт. нояб. 11 14:50:32
  # Чт. нояб. 13 11:00:00
  let(:notes) { [
      { id: 1, task_id: 1, text: 'Заметка 1', created_at: 1415337023 },
      { id: 2, task_id: 2, text: 'Заметка 2', created_at: 1415699432 },
      { id: 3, task_id: 3, text: 'Заметка 3', created_at: 1415858400 }
    ] }

  let(:report) { {
    tasks: 
    [
      tasks[2], tasks[1]
    ],
    events:
    [
      {object: :task, status: :created, task_id: tasks[2][:id], text: tasks[2][:title], timestamp: tasks[2][:created_at]},
      {object: :subtask, status: :created, task_id: tasks[2][:id], text: subtasks[2][:title], timestamp: subtasks[2][:created_at]},
      {object: :note, status: :created, task_id: tasks[2][:id], text: notes[2][:text], timestamp: notes[2][:created_at]},
      {object: :note, status: :created, task_id: tasks[1][:id], text: notes[1][:text], timestamp: notes[1][:created_at]},
      {object: :subtask, status: :finished, task_id: tasks[1][:id], text: subtasks[1][:text], timestamp: subtasks[1][:finished_at]}
    ]
  } }

  before(:each) do
    FileUtils.cp(CLEANDB, TESTDB)
    db = Sequel.sqlite(TESTDB)
    {tasks: tasks, subtasks: subtasks, notes: notes}.each do |table_name, data|
      table = db[:"#{table_name}"]
      data.each do |record|
        table.insert(record)
      end
    end
    ENV['POTAMTIME'] = '1415812666'
    ENV['POTAM'] = 'test'
    @report = Report.new(db)
  end

  after(:each) do
    FileUtils.cp(CLEANDB, TESTDB)
    ENV['POTAM'] = 'production'
  end

  describe '#week' do
    it 'should return weekly report' do
      expect(@report.week).to eq(report)
    end
  end

  describe '#to_event' do
    it 'should add task to events if its date is in report range' do
      @report.__send__(:to_event, tasks[2])
      expect(@report.instance_variable_get(:@report)[:events][0]).to eq(report[:events][0])
    end
    it 'should not add task to events if its date not is in report range' do
      @report.__send__(:to_event, tasks[1])
      expect(@report.instance_variable_get(:@report)[:events][0]).to be_nil
    end
  end

end