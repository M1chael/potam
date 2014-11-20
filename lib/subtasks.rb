class Subtasks < DB
  
  def finish!(id)
    @table.where("id = ?", id.to_i).update(status: 1)
  end

end