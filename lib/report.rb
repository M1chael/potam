require 'timer'

class Report

  include Timer

  def initialize(db = Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
    @db = db
    @report = Hash.new
    @report[:events] = Array.new
  end

  def week
    @report[:tasks] = @db.fetch("SELECT * FROM tasks 
      WHERE (created_at BETWEEN #{last_mon} AND #{now}) 
        OR id IN (SELECT task_id FROM subtasks WHERE (created_at BETWEEN #{last_mon} AND #{now}) 
        OR (finished_at BETWEEN #{last_mon} AND #{now})) 
        OR id IN (SELECT task_id FROM notes WHERE (created_at BETWEEN #{last_mon} AND #{now}))
        ORDER BY id DESC").to_a
  end

  private

  def to_event(object)
    if object[:description]
      @report[:events] << 
        {object: :task, status: :created, task_id: object[:id], 
          text: object[:title], timestamp: object[:created_at]} #if object[:created_at].between?(last_mon, now)
    elsif object[:text]
      @report[:events] << 
        {object: :note, status: :created, task_id: object[:task_id], 
          text: object[:text], timestamp: object[:created_at]}
    else

    end
  end

end