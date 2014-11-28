require 'timer'

class Report

  include Timer

  def initialize(db = Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
    @db = db
  end

  def week
    tasks = @db.fetch("SELECT * FROM tasks 
      WHERE (created_at BETWEEN #{last_mon} AND #{now}) 
        OR id IN (SELECT task_id FROM subtasks WHERE (created_at BETWEEN #{last_mon} AND #{now}) 
        OR (finished_at BETWEEN #{last_mon} AND #{now})) 
        OR id IN (SELECT task_id FROM notes WHERE (created_at BETWEEN #{last_mon} AND #{now}))
        ORDER BY id DESC").to_a
  end

end