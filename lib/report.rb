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
    order = Array.new
    @report[:tasks].each{ |task| order << task[:id] }
    @report[:tasks].select{ |task| task[:created_at].between?(last_mon, now) }.each{ |task| to_event(task) }
    @db[:notes].where("created_at BETWEEN #{last_mon} AND #{now}").all.each{ |note| to_event(note) }
    @db[:subtasks].where("created_at BETWEEN #{last_mon} AND #{now}").all.each{ |subtask| to_event(subtask) }
    @db[:subtasks].where("finished_at BETWEEN #{last_mon} AND #{now}").all.each{ |subtask| to_event(subtask, :finished) }
    @report[:events].sort_by!{ |event| [order.index(event[:task_id]), event[:timestamp]] }
    return @report
  end

  protected

  def to_event(object, status = :created)
    if object[:description]
      @report[:events] << 
        {object: :task, status: :created, task_id: object[:id], 
          text: object[:title], timestamp: object[:created_at]}
    elsif object[:text]
      @report[:events] << 
        {object: :note, status: :created, task_id: object[:task_id], 
          text: object[:text], timestamp: object[:created_at]}
    else
      @report[:events] << 
        {object: :subtask, status: status, task_id: object[:task_id], 
          text: object[:title], timestamp: object[:"#{status}_at"]}
    end
  end

end