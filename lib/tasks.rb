require 'sequel'

class Tasks

  attr_reader :new_task_id

  def initialize(db)
    @db = db
    @tasks = @db[:tasks]
  end

  def create(options = {})
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    @new_task_id = @tasks.insert(title: @title, description: @description, created_at: @created_at)
  end

  def last
    @tasks.order(Sequel.desc(:id)).limit(10).all
  end

  def list
    @tasks.order(Sequel.desc(:id)).all
  end

end