require 'timer'

class DB

  include Timer

  @@logged = true

  def initialize(db = Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
    @db = db
    table_name = self.class.name.downcase
    @record_name = table_name[0..-2]
    self.class.__send__(:attr_reader, "new_#{@record_name}_id")
    # @db = db
    # instance_variable_set('@table', db[:"#{table_name}"])
    @table = @db[:"#{table_name}"]
    # Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../test/test.db")
    # @db = db
    # @tasks = @db[:tasks]
  end

  def create(record)
    record[:created_at] = now if @@logged
    instance_variable_set("@new_#{@record_name}_id", @table.insert(record))
  end

  # def create(options = {})
  #   options.each do |key, value|
  #     instance_variable_set("@#{key}", value)
  #   end
  #   @new_task_id = @tasks.insert(title: @title, description: @description, created_at: @created_at)
  # end

  def last(task_id = false)
    select_by_task_id(task_id).order(Sequel.desc(:id)).limit(10).all
  end

  def list(task_id = false)
    select_by_task_id(task_id).order(Sequel.desc(:id)).all
  end

  def info(id)
    @table.where("id = ?", id.to_i).first
  end

  protected

  def select_by_task_id(task_id)
    task_id ? @table.where("task_id = ?", task_id.to_i) : @table
  end

  # def time
  #   time = ENV['POTAM'] == 'test' ? ENV['POTAMTIME'].to_i : Time.now.to_i
  # end

end