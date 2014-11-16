class Notes

  attr_reader :new_note_id

  def initialize(db)
    @db = db
    @notes = @db[:notes]
  end

  def create(options = {})
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    @new_note_id = @notes.insert(task_id: @task_id, text: @text, created_at: @created_at)
  end

end