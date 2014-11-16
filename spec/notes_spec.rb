require 'spec_helper'
require 'notes'

describe Notes do
  let(:notes) { [
      { id: 1, task_id: 1, text: 'Заметка 1', created_at: 1415791040 },
      { id: 2, task_id: 2, text: 'Заметка 2', created_at: 1415791041 },
      { id: 3, task_id: 3, text: 'Заметка 3', created_at: 1415791042 },
      { id: 4, task_id: 4, text: 'Заметка 4', created_at: 1415791043 },
      { id: 5, task_id: 5, text: 'Заметка 5', created_at: 1415791044 },
      { id: 6, task_id: 6, text: 'Заметка 6', created_at: 1415791045 },
      { id: 7, task_id: 7, text: 'Заметка 7', created_at: 1415791046 },
      { id: 8, task_id: 8, text: 'Заметка 8', created_at: 1415791047 },
      { id: 9, task_id: 9, text: 'Заметка 9', created_at: 1415791048 },
      { id: 10, task_id: 1, text: 'Заметка 10', created_at: 1415791049 },
      { id: 11, task_id: 1, text: 'Заметка 11', created_at: 1415791050 },
      { id: 12, task_id: 1, text: 'Заметка 12', created_at: 1415791051 },
      { id: 13, task_id: 1, text: 'Заметка 13', created_at: 141579104052 },
    ] }

  describe 'Notes#create' do
    it 'should save note to DB' do
      db = double(Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
      db_notes = double
      notes.each do |note|
        allow(db).to receive(:[]).with(:notes) { db_notes }
        expect(db_notes).to receive(:insert).with(
          task_id: note[:task_id], text: note[:text], created_at: note[:created_at])
        test_notes = Notes.new(db)
        test_notes.create(task_id: note[:task_id], text: note[:text], created_at: note[:created_at])
      end
    end
  end
end