class Subtasks

  attr_reader :new_subtask_id

  def initialize(db)
    @db = db
    @subtasks = @db[:subtasks]
  end

  def create(options = {})
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    @new_subtask_id = @subtasks.insert(task_id: @task_id, title: @title, status: @status, created_at: @created_at)
  end

end