class Tasks < DB

  def last
    @db.fetch("SELECT * FROM tasks AS T ORDER BY (SELECT MAX(ts) FROM 
      (SELECT notes.created_at AS ts FROM notes WHERE task_id = T.id 
        UNION SELECT subtasks.created_at AS ts FROM subtasks WHERE task_id = T.id 
        UNION SELECT subtasks.finished_at AS ts FROM subtasks WHERE task_id = T.id 
        UNION SELECT tasks.created_at AS ts FROM tasks WHERE id = T.id)) DESC LIMIT 0, 10;").to_a
  end

  def list
    @db.fetch("SELECT * FROM tasks AS T ORDER BY (SELECT MAX(ts) FROM 
      (SELECT notes.created_at AS ts FROM notes WHERE task_id = T.id 
        UNION SELECT subtasks.created_at AS ts FROM subtasks WHERE task_id = T.id 
        UNION SELECT subtasks.finished_at AS ts FROM subtasks WHERE task_id = T.id 
        UNION SELECT tasks.created_at AS ts FROM tasks WHERE id = T.id)) DESC;").to_a
  end

end