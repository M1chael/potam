class DB

  # attr_reader :new_test_id

  def initialize(db = Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
    table_name = self.class.name.downcase
    @record_name = table_name[0..-2]
    self.class.__send__(:attr_reader, "new_#{@record_name}_id")
    # @db = db
    # instance_variable_set('@table', db[:"#{table_name}"])
    @table = db[:"#{table_name}"]
    # Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../test/test.db")
    # @db = db
    # @tasks = @db[:tasks]
  end

  def create(record)
    instance_variable_set("@new_#{@record_name}_id", @table.insert(record))
  end

  # def create(options = {})
  #   options.each do |key, value|
  #     instance_variable_set("@#{key}", value)
  #   end
  #   @new_task_id = @tasks.insert(title: @title, description: @description, created_at: @created_at)
  # end

  def last
    @table.order(Sequel.desc(:id)).limit(10).all
  end

  def list
    @table.order(Sequel.desc(:id)).all
  end

  def info(id)
    @table.where("id = ?", id.to_i).first
  end

end