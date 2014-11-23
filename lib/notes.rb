class Notes < DB

  def last(task_id)
    @table.where("task_id = ?", task_id.to_i).order(Sequel.desc(:id)).limit(10).all
  end

  def list(task_id)
    @table.where("task_id = ?", task_id.to_i).order(Sequel.desc(:id)).all
  end

end