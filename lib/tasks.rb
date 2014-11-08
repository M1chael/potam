require 'sequel'

class Tasks

  def initialize(db)
    @db = db
    @tasks = @db[:tasks]
  end

  def create(options = {})
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    @tasks.insert(title: @title, description: @description)
  end

end