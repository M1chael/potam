class Subtasks < DB
  
  def finish!(id)
    @table.where("id = ?", id.to_i).update(status: 1, finished_at: time)
  end

  def active(task_id)
    @table.where("task_id = ?", task_id.to_i).where("status = ?", 0).order(Sequel.desc(:id)).all
  end

end